execute pathogen#infect()

"color scheme
let g:rehash256 = 1
colorscheme molokai
syntax enable
let g:solarized_termcolors=256

"enable mouse
set mouse=a

"set spacing
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set breakindent

" UI configuration
set number relativenumber
set showcmd
set cursorline
filetype indent on
set wildmenu
set lazyredraw
set showmatch
set laststatus=2
set splitright
set splitbelow
set backspace=indent,eol,start

" search settings
set incsearch
set hlsearch
set ignorecase
set smartcase
au InsertEnter * set noignorecase
au InsertLeave * set ignorecase

" arrow keys
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <Up> <Nop>
noremap <Down> <Nop>
vmap <Left> <gv
vmap <Right> >gv
nnoremap < V<
nnoremap > V>

" naviagtion in insert
inoremap <c-h> <Left>
inoremap <c-j> <Down>
inoremap <c-k> <Up>
inoremap <c-l> <Right>
inoremap <c-w> <esc>lwi
inoremap <c-b> <esc>lbi

" ctrl-paste to paste in insert
inoremap <c-p> <esc>pli
" paste from clipboard register
nnoremap P "+p
" paste in selection without deleting yanked text
vnoremap p <esc>`>pgv"_d

" make things a little easier
map qq :bd<cr>
:command W w
:command Q q
:command Wq wq
:command WQ wq
:command Qa qa
" this doesn't really work
:command JSON %!python3 -m json.tool<cr>

" leave marks when going top or bottom or searching
nnoremap <silent> T magg
nnoremap <silent> G maG
nnoremap / ms/

" open tags in new tab
nnoremap <c-\> <c-w><c-]><c-w>T
" yank leaves cursor at bottom of selection
vnoremap y ygv<esc>
" copy to clipboard with Y in visual mode
vmap Y "*y<esc>
" yank from cursor to end of the line with Y in normal mode
nmap Y v$hy<esc>
" replace with r
nnoremap r *Ncgn
" delete to end and front of line
nnoremap cI c^
nnoremap cA c$
nnoremap dI d^
nnoremap dA d$

" faster vertical moving
nnoremap J 5j
nnoremap K 5k
vnoremap J 5j
vnoremap K 5k

" buffers
nnoremap <c-l> :ls<cr>
nnoremap <c-n> :bN<cr>
nnoremap <c-m> :bn<cr>
nnoremap <leader>q :bd<cr>

" folding
set foldenable
set foldlevelstart=10
nnoremap , za
set foldmethod=syntax

" leader stuff
let mapleader=" "
nnoremap <leader>w :w<cr>
nnoremap <silent> <leader><space> :noh<CR>
nnoremap <leader>s :mksession!<CR>

" escape is far
inoremap jk <esc>
inoremap jj <esc>

" don't use enter in normal mode
nmap <cr> <nop>

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

" filetype customizations
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
    autocmd BufEnter *.js setlocal tabstop=2
    autocmd BufEnter *.js setlocal shiftwidth=2
    autocmd BufEnter *.js setlocal softtabstop=2
augroup END

" git commands on current file
fun! GitCommand(command)
  silent! !clear
  exec "!git " . a:command . " %"
endfun
map <leader>d :call GitCommand("diff") <CR>
map <leader>l :call GitCommand("lol") <CR>
map <leader>b :call GitCommand("blame -C -C") <CR>

" ================ PLUGINS ================

" ctrlp
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
" open file in new tab upon <cr>
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }
nnoremap <c-o> :CtrlPBuffer<cr>
nnoremap <c-b> :b#<cr>

" nerdtree
function OpenNERDTreeTabHere()
 tabe %
 NERDTreeFind %
endfunction
function OpenNERDTreeSplitHere()
 vs %
 NERDTreeFind %
endfunction
:command T call OpenNERDTreeTabHere()
:command S call OpenNERDTreeSplitHere()
map - :NERDTreeFind<cr>
map = :NERDTreeToggle<cr>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeIgnore = ["\.pyc$", "^__pycache__$"]

" airline
let g:airline_theme="bubblegum"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#tab_nr_type= 2
autocmd VimEnter * highlight airline_tabfill ctermbg=237

" vimux
:command Vp VimuxPromptCommand
