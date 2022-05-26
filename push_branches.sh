#!/bin/bash
set -e

REMOTE=origin

# TODO push a branch for the base of this commit
# TODO extract the PR for the commit beneath this to add a comment saying what PR this is based on

function push_branch {
  commit=$1
  BRANCH_NAME=$(git log --format=%B -n 1 $commit | grep feature-branch | sed 's/feature-branch: //g')
  echo ""
  echo "========================Pushing $commit $BRANCH_NAME ================================"
  [ -z "$BRANCH_NAME" ] && echo "Error: branch name not specified for $commit. Add \"feature-branch: \" attribute to the commit message." && exit 1

  # Save old commit hash before force pushing, if the branch exists
  OLD_COMMIT_HASH=$(git rev-parse --quiet --verify $REMOTE/$BRANCH_NAME || true)

  if [ "$commit" = "$OLD_COMMIT_HASH" ]; then
    echo "Branch $BRANCH_NAME is already up to date."
    return 0
  fi

  git push $REMOTE $commit:refs/heads/$BRANCH_NAME -f
  echo "Force pushed to $BRANCH_NAME."
  [[ ! -z "$OLD_COMMIT_HASH" ]] && echo "Check out old commit at $OLD_COMMIT_HASH."
}

echo "Refreshing all remote branches..."
git fetch -p

echo "Pushing changes on this branch, one commit at a time"
REMOTE=origin
commits=$(git log --format=format:"%H" --reverse $REMOTE/master..HEAD)
for commit in $commits
do
  push_branch $commit
done
