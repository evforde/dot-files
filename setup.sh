#!/bin/bash
mkdir -p ~/.vim/colors
cp ./molokai.vim ~/.vim/colors/molokai.vim

git clone https://github.com/tpope/vim-vinegar.git ~/.vim/bundle/vim-vinegar
git clone https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline

mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

brew install ctags

git config --global alias.lol "log --graph --oneline --decorate --color --all"
git config --global user.name "Elliott Forde"
echo "\nDon't forget to set your GitHub email!"
echo "Don't forget to set your GitHub email!"
echo "Don't forget to set your GitHub email!"

