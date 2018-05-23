#!/bin/bash
mkdir -p ~/.vim/colors
cp ./molokai.vim ~/.vim/colors/molokai.vim

sh -c "mkdir -p ~/.vim/bundle && cd ~/.vim/bundle && git clone https://github.com/tpope/vim-vinegar.git" 
sh -c "mkdir -p ~/.vim/bundle && cd ~/.vim/bundle && git clone https://github.com/ctrlpvim/ctrlp.vim.git ctrlp.vim" 
