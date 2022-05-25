#!/bin/bash
set -e

BRANCH_NAME=$(git log --format=%B -n 1 | grep feature-branch | sed 's/feature-branch: //g')
[ -z "$BRANCH_NAME" ] && echo 'Error: branch name not specified. Add "feature-branch: " attribute to the commit message.' && exit 1
OLD_COMMIT_HASH=$(git log -1 --format=format:"%H" origin/$BRANCH_NAME || echo '')
git push origin HEAD:$BRANCH_NAME -f
echo "Force pushed to $BRANCH_NAME."
[[ ! -z "$OLD_COMMIT_HASH" ]] && echo "Check out old commit at $OLD_COMMIT_HASH."
