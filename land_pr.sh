#!/bin/bash
set -e

# TODO enforce branches are pushed
# TODO ask to confirm landing
# TODO what happens if pr not accepted?

REMOTE=origin

function get_branch_from_commit {
  COMMIT=$1
  BRANCH_NAME=$(git log --format=%B -n 1 $COMMIT | grep feature-branch | sed 's/feature-branch: //g')
  echo "$BRANCH_NAME"
}

echo "Refreshing all remote branches..."
git fetch -p

COMMIT=$1
shift
BRANCH_NAME=$(get_branch_from_commit $COMMIT)

echo "========================Landing $COMMIT $BRANCH_NAME ================================"
NUM_COMMITS_SINCE_MASTER=$(git log --format=format:"%H" $REMOTE/master..$REMOTE/$BRANCH_NAME | wc -w)
[[ ! $NUM_COMMITS_SINCE_MASTER -eq 1 ]] && echo "Not rebased on $REMOTE/master" && exit 1
echo "Updating PR base branch to master"

gh pr edit $BRANCH_NAME -B master
gh pr merge $BRANCH_NAME --delete-branch --squash "$@"
git push $REMOTE base/$BRANCH_NAME --delete
git fetch -p

# TODO rebase stack on master
