execute pathogen#infect()

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

" UI configuration
set number
set number relativenumber
set showcmd
set cursorline
filetype indent on
set wildmenu
set lazyredraw
set showmatch

" search settings
set incsearch
set hlsearch
set ignorecase
set smartcase

" make things a little easier
map qq :q<Enter>
:command W w
:command Q q
:command Wq wq
:command WQ wq

"Faster vertical moving
nnoremap J 10j
nnoremap K 10k

" folding
set foldenable
set foldlevelstart=10
nnoremap <space> za
set foldmethod=syntax

" leader stuff
let mapleader=" "
nnoremap <leader><space> :noh<CR>
nnoremap <leader>s :mksession<CR>
noremap <leader>j gt
noremap <leader>k gT
" ctrl + i for ith tab
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" escape is far
inoremap jk <esc>

" ctrl jk for tabs, ctrl hl for windows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-h> <c-w>h
map <c-l> <c-w>l
set virtualedit+=onemore

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

" nertw defaults
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 20
let g:netrw_altv = 1

" ctrlp
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
nnoremap <leader>. :CtrlPTag<cr>
" auto open in new tab
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }

" nerdtree
autocmd StdinReadPre * let s:std_in=1 " open NERDTree if no file provided
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" exit if nerdtree is last window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map - :NERDTreeFind<enter>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
