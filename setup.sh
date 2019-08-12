#!/bin/bash
./vim_setup.sh

brew install vim
brew install ctags
brew install ag

git config --global alias.lol "log --graph --oneline --decorate --color --all"
git config --global user.name "Elliott Forde"

# iterm settings
mkdir -p ~/Library/Application\ Support/iTerm2/Scripts/Auto-Launch/
ln ~/.dot-files/iterm/folder_title.py ~/Library/Application\ Support/iTerm2/Scripts/Auto-Launch/folder_title.py

echo ""
echo "Don't forget to set your GitHub email!"
