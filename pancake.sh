SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"

jj-watch () {
  watch -n 1 --color --no-wrap jj --color=always --ignore-working-copy
}

jj-sync() {(
  set -euo pipefail
  DEFAULT_BRANCH=$(jj log -r "local_trunk()" -T "local_bookmarks.filter(|b| b.name() == 'master' || b.name() == 'main' || b.name() == 'trunk')" --no-pager --no-graph --color=never)
  jj git fetch -b $DEFAULT_BRANCH -b "glob:$USER/*"
  jj bookmark set $DEFAULT_BRANCH --to "trunk()"

  jj-restack
  jj-abandon
)}

jj-abandon() {(
  set -euo pipefail

  # Prompt the user to locally abandon changes for any PRs that are merged or closed.
  for CHANGE_ID in $(jj log -r "mine() & trunk().. & ~empty() & ~immutable()" --no-pager --no-graph --color=never -T 'change_id.shortest(8) ++ "\n"'); do
    PR_INFO=$(gh pr list --state all -H "$USER/$CHANGE_ID" --json state,title,url --limit 1 -q '.[]')
    PR_STATE=$(echo $PR_INFO | jq -r '.state')
    PR_TITLE=$(echo $PR_INFO | jq -r '.title')
    PR_URL=$(echo $PR_INFO | jq -r '.url')
    if [[ "$PR_STATE" == "CLOSED" || "$PR_STATE" == "MERGED" ]]; then
      echo "PR is $PR_STATE: $PR_TITLE"
      echo "Would you like to abandon $CHANGE_ID? (Y/n)"
      while true; do
        read yn
        case $yn in
            [Yy]* ) jj abandon $CHANGE_ID; jj bookmark forget mq/$CHANGE_ID; break;;
            [Nn]* ) break;;
            * ) echo "Please answer yes or no.";;
        esac
      done
    fi
  done
)}

jj-restack() {(
  set -euxo pipefail
  jj rebase -b "all:(mine() & local_trunk().. & ~empty() & ~immutable())" -d "trunk()" --skip-emptied
)}

jj-submit-all() {(
  set -euo pipefail

  if [[ $# -eq 0 ]]; then
    REVSET="@"
  else
    REVSET="$1"
  fi

  for CHANGE_ID in $(jj log -r "mine() & trunk().. & ~empty() & $REVSET" --no-pager --no-graph --color=never -T 'change_id.shortest(8) ++ "\n"'); do
    echo Submitting $CHANGE_ID...
    jj-submit-no-comment $CHANGE_ID
    echo
  done

  uv run --python 3.9.11 --with-requirements "$SCRIPT_DIR/pancake/requirements.txt" python3 "$SCRIPT_DIR/pancake/pancake.py" $REVSET
)}

jj-submit() {(
  set -euo pipefail

  jj-submit-no-comment $1
  uv run --python 3.9.11 --with-requirements "$SCRIPT_DIR/pancake/requirements.txt" python3 "$SCRIPT_DIR/pancake/pancake.py" $1
)}

jj-comment-all() {(
  set -euo pipefail

  REVSET="$1"
  for CHANGE_ID in $(jj log -r "mine() & trunk().. & ~empty() & $REVSET" --no-pager --no-graph --color=never -T 'change_id.shortest(8) ++ "\n"'); do
    jj-comment $CHANGE_ID
  done
)}

jj-submit-no-comment() {(
  set -euo pipefail

  COMMIT=$1;
  CHANGE_ID="$(jj log --template 'change_id.shortest(8)' --no-pager --no-graph --color=never -r "$COMMIT & ~immutable() & ~conflicts() & ~empty()")"
  if [[ -z $CHANGE_ID ]]; then
    echo "No pushable change found for revset $COMMIT. Please make sure it is mutable, it is not empty, and it does not contain any conflicts."
    return 1
  fi
  BRANCH_NAME="$USER/$(jj log --template 'change_id.shortest(8)' --no-pager --no-graph --color=never -r $CHANGE_ID)"

  MQ_CHANGE_ID=$(jj log -T 'if(parents.len() == 1, parents.map(|p| p.change_id()))' -r $COMMIT --no-pager --no-graph --color=never)
  MQ_BRANCH_NAME="mq/$CHANGE_ID"

  jj bookmark set $BRANCH_NAME -r $CHANGE_ID --allow-backwards
  jj bookmark set $MQ_BRANCH_NAME -r $MQ_CHANGE_ID --allow-backwards

  jj git push -b glob:"*/$CHANGE_ID" --allow-new
  if [[ "$(gh pr list --head $BRANCH_NAME --json number)" == "[]" ]]; then
    echo Creating PR...
    gh pr create --head $BRANCH_NAME --base $MQ_BRANCH_NAME --draft --fill
  else
    # Reset the base. Seems to be necessary to get the PR to update.
    echo Updating PR...
    gh pr edit $BRANCH_NAME --base $MQ_BRANCH_NAME
  fi
)}

jj-comment() {(
  set -euo pipefail

  COMMIT=$1;
  CHANGE_ID="$(jj log --template 'change_id.shortest(8)' --no-pager --no-graph --color=never -r "$COMMIT & ~immutable() & ~conflicts() & ~empty()")"
  if [[ -z $CHANGE_ID ]]; then
    echo "No pushable change found for revset $COMMIT. Please make sure it is mutable, it is not empty, and it does not contain any conflicts."
    return 1
  fi
  BRANCH_NAME="$USER/$(jj log --template 'change_id.shortest(8)' --no-pager --no-graph --color=never -r $CHANGE_ID)"

  echo "Building PR stack comment for $BRANCH_NAME"

  # Build PR comment.
  LOG=$(jj log -r "(fork_point(local_trunk()::$CHANGE_ID)::$CHANGE_ID | $CHANGE_ID::latest(heads($CHANGE_ID:: & bookmarks(glob:'$USER/*')))) & bookmarks(glob:'$USER/*')" --no-pager --color=never --no-graph -T "'- REPLACE_BRANCH_NAME:' ++ remote_bookmarks.filter(|b| b.name().starts_with('$USER/') && b.remote() == 'git').map(|b| b.name()) ++ \"\n\"")
  echo $LOG | grep -o 'REPLACE_BRANCH_NAME.\+' | while read -r PATTERN; do
    STK_BRANCH_NAME=$(echo $PATTERN | sed -E 's/REPLACE_BRANCH_NAME:(.*)/\1/')
    PR_NUMBER="$(gh pr view $STK_BRANCH_NAME --json number --template '{{ .number }}')"
    PATTERN_ESCAPE=$(echo $PATTERN | sed -E 's/\//\\\//g')

    SUFFIX=""
    if [[ $STK_BRANCH_NAME == $BRANCH_NAME ]]; then
      SUFFIX=" 👈"
    fi
    LOG=$(echo $LOG | sed -E "s/$PATTERN_ESCAPE/#$PR_NUMBER$SUFFIX/g")
  done

  DEFAULT_BRANCH=$(jj log -r "local_trunk()" -T "local_bookmarks.filter(|b| b.name() == 'master' || b.name() == 'main' || b.name() == 'trunk')" --no-pager --no-graph --color=never)

  COMMENT_FILE=$(mktemp)
  echo "### 🥞 Pull Request Stack" >> $COMMENT_FILE
  echo $LOG >> $COMMENT_FILE
  echo "- \`$DEFAULT_BRANCH\`" >> $COMMENT_FILE
  echo "<!-- this_is_the_jj_pr_stack_comment -->" >> $COMMENT_FILE

  # Create or update PR comment.
  PR_NUMBER=$(gh pr list --head $BRANCH_NAME --json number | jq ".[] | .number")
  OWNER_REPO=$(gh repo view --json owner,name --template "{{ .owner.login }}/{{ .name }}")
  EXISTING_COMMENT=$(gh api --method GET repos/${OWNER_REPO}/issues/${PR_NUMBER}/comments | jq '.[] | select(.body | contains("this_is_the_jj_pr_stack_comment")) | .id')
  if [[ -n $EXISTING_COMMENT ]]; then
    gh api --method PATCH repos/${OWNER_REPO}/issues/comments/${EXISTING_COMMENT} -F body=@$COMMENT_FILE --silent
  else
    gh pr comment $PR_NUMBER --body-file $COMMENT_FILE > /dev/null
  fi

  rm $COMMENT_FILE
)}

jj-s() {(
  if [[ $# -eq 0 ]]; then
    REVSET="@"
  else
    REVSET="$1"
  fi

  preview_cmd="jj diff --color=always -r $REVSET {1} --git | delta --side-by-side --minus-style \"syntax #500000\" --plus-style \"syntax #005000\" -w 200"

  jj show $REVSET -T 'description.first_line() ++ "\n"' --name-only | \
    fzf --ansi --tac --preview "$preview_cmd" --preview-window "right,80%" --header-lines 1 > /dev/null
)}
