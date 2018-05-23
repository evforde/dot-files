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

"Close and write files
map qq :q<Enter>

"Common mistakes
:command W w
:command Q q
:command Wq wq
:command WQ wq

"Faster vertical moving
nnoremap J 10j
nnoremap K 10k

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

" escape is far
inoremap jk <esc>

" ctrl jk for tabs, ctrl hl for windows
nnoremap <c-k> gt
nnoremap <c-j> gT
map <c-h> <c-w>h
map <c-l> <c-w>l
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

" nertw defaults
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 20
let g:netrw_altv = 1

" ctrl + i for ith window - doesn't work
let i = 1
while i <= 9
    execute 'nnoremap <Leader>' . i . ' :' . i . 'wincmd w<CR>'
    let i = i + 1
endwhile

" ctrlp
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
nnoremap <leader>. :CtrlPTag<cr>

" nerdtree
autocmd StdinReadPre * let s:std_in=1 " open NERDTree if no file provided
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" exit if nerdtree is last window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map - :NERDTree<enter>
