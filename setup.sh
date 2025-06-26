#!/bin/bash
./vim_setup.sh

brew install vim
brew install ctags
brew install ag
brew install jj
brew install delta

git config --global alias.lol "log --graph --oneline --decorate --color --all"
git config --global user.name "Elliott Forde"

# iterm settings
mkdir -p ~/Library/Application\ Support/iTerm2/Scripts/Auto-Launch/
ln ~/dot-files/iterm/folder_title.py ~/Library/Application\ Support/iTerm2/Scripts/Auto-Launch/folder_title.py

ln -s ~/dot-files/.bash_profile ~/.bash_profile
ln -s ~/dot-files/.vimrc ~/.vimrc
ln -s ~/dot-files/.vimrc_vscode ~/.vimrc_vscode
ln -s ~/dot-files/.zshrc ~/.zshrc
mkdir -p ~/.config/jj
ln -s ~/dot-files/jj-config.toml ~/.config/jj/config.toml

echo ""
echo "Don't forget to set your GitHub email!"
