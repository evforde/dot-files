"color scheme
let g:rehash256 = 1
colorscheme molokai 
syntax enable

"enable mouse
set mouse=a

"set spacing
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

"UI configuration
set number
set number relativenumber
set showcmd
set cursorline
filetype indent on
set wildmenu
set lazyredraw
set showmatch

"search settings
set incsearch
set hlsearch
set ignorecase
set smartcase

"folding
set foldenable
set foldlevelstart=10
nnoremap <space> za
set foldmethod=syntax

nnoremap B ^ "move to beginning of line
nnoremap E $ "move to end of line
nnoremap ^ <nop>
nnoremap $ <nop>

let mapleader=","
nnoremap <leader><space> :noh<CR>
nnoremap <leader>s :mksession<CR>

inoremap jk <esc>
nnoremap <c-k> gt
nnoremap <c-j> gT
set virtualedit+=onemore

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

au BufNewFile,BufRead SCons* set filetype=scons
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd FileType python setlocal foldmethod=indent
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END

