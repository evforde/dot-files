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

" navigate around in insert mode
inoremap <c-h> <Left>
inoremap <c-j> <Down>
inoremap <c-k> <Up>
inoremap <c-l> <Right>

" make things a little easier
map qq :q<Enter>
:command W w
:command Q q
:command Wq wq
:command WQ wq
" go to top of file
nnoremap T :0<CR>
" go to last touched line
nnoremap m ``
" open tags in new tab
nnoremap <c-\> <c-w><c-]><c-w>T

"Faster vertical moving
nnoremap J 10j
nnoremap K 10k

" folding
set foldenable
set foldlevelstart=10
nnoremap , za
set foldmethod=syntax

" leader stuff
let mapleader=" "
nnoremap <leader><space> :noh<CR>
nnoremap <leader>s :mksession<CR>
" space + i for ith tab
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
inoremap jj <esc>

" ctrl ui for tabs, hjkl for windows
noremap <c-u> gT
noremap <c-i> gt
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-h> <c-w>h
map <c-l> <c-w>l
set virtualedit+=onemore

" highlight past 80 characters in active window
set colorcolumn=80
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinEnter * set colorcolumn=80
    autocmd WinLeave * set nocul
    autocmd WinLeave * set colorcolumn=0
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

" git commands on current file
fun! GitCommand(command)
  silent! !clear
  exec "!git " . a:command . " %"
endfun
map <leader>d :call GitCommand("diff") <CR>
map <leader>l :call GitCommand("lol") <CR>
map <leader>b :call GitCommand("blame") <CR>

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
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map - :NERDTreeFind<enter>
map = :NERDTreeToggle<enter>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeIgnore = ['\.pyc$']
