#!/bin/bash
set -e

# TODO push a branch for the base of this commit
# TODO extract the PR for the commit beneath this to add a comment saying what PR this is based on
# TODO git fetch -p. iterate over all commits on this branch. see which local commits differ from remote branch and push for those

BRANCH_NAME=$(git log --format=%B -n 1 | grep feature-branch | sed 's/feature-branch: //g')
[ -z "$BRANCH_NAME" ] && echo 'Error: branch name not specified. Add "feature-branch: " attribute to the commit message.' && exit 1

# Save old commit hash before force pushing, if the branch exists
OLD_COMMIT_HASH=$(git rev-parse --quiet --verify origin/$BRANCH_NAME || true)

git push origin HEAD:refs/heads/$BRANCH_NAME -f
echo "Force pushed to $BRANCH_NAME."
[[ ! -z "$OLD_COMMIT_HASH" ]] && echo "Check out old commit at $OLD_COMMIT_HASH."
