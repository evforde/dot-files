#!/bin/bash
mkdir -p ~/.vim/colors
cp ./molokai.vim ~/.vim/colors/molokai.vim

sh -c "cd ~/.vim && git clone https://github.com/kien/ctrlp.vim.git bundle/ctrlp.vim"
