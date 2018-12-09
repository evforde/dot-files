#!/bin/bash
./vim_setup.sh

brew install vim
brew install ctags

git config --global alias.lol "log --graph --oneline --decorate --color --all"
git config --global user.name "Elliott Forde"

echo ""
echo "Don't forget to set your GitHub email!"
