#!/bin/bash
mkdir -p ~/.vim/colors
cp ./molokai.vim ~/.vim/colors/molokai.vim


# install vim from source
cd ~
git clone https://github.com/vim/vim.git
cd vim
# Requires homebrew vim to be installed!
# ./configure --with-features=huge --disable-pythoninterp --enable-python3interp vi_cv_path_python3=/usr/local/bin/python3.6 && make && sudo make install
# I think this is the proper way to compile vim from source
./configure --with-features=huge --disable-pythoninterp --enable-python3interp vi_cv_path_python3=/usr/local/bin/python3.6 --with-python3-command=python3 && make && sudo make install


# TODO migrate these to vimrc
# file navigation 
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
git clone https://github.com/tpope/vim-vinegar.git ~/.vim/bundle/vim-vinegar
git clone https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim

# status line
git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/bundle/vim-airline-themes
git clone https://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized
git clone https://github.com/evforde/taghelper.vim.git ~/.vim/bundle/taghelper

# coding
git clone https://github.com/Yggdroot/indentLine.git ~/.vim/bundle/indentLine
git clone https://github.com/ervandew/supertab.git ~/.vim/bundle/supertab
git clone https://github.com/saltstack/salt-vim.git ~/.vim/bundle/salt-vim
git clone --recursive https://github.com/python-mode/python-mode.git ~/.vim/bundle/python-mode

# sessions
git clone https://github.com/tpope/vim-obsession.git ~/.vim/bundle/vim-obsession

# git
git clone https://github.com/airblade/vim-gitgutter.git ~/.vim/bundle/vim-gitgutter
git clone https://github.com/tpope/vim-fugitive.git ~/.vim/bundle/vim-fugitive
git clone https://github.com/tpope/vim-rhubarb.git ~/.vim/bundle/vim-rhubarb

# tmux stuff
git clone https://github.com/benmills/vimux.git ~/.vim/bundle/vimux

# searching
git clone https://github.com/mileszs/ack.vim.git ~/.vim/bundle/ack.vim

mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
