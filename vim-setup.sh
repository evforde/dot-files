#!/bin/bash
mkdir -p ~/.vim/colors
cp ./molokai.vim ~/.vim/colors/molokai.vim

git clone https://github.com/tpope/vim-vinegar.git ~/.vim/bundle/vim-vinegar
git clone https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

brew install ctags
