execute pathogen#infect()
execute pathogen#helptags()

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
set breakindentopt=min:40
set breakat=80
set wrap
let &showbreak = '↳ '
set cpo+=n

" UI configuration
set number relativenumber
set showcmd
set cursorline
filetype plugin indent on
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

" search highlighted text in visual mode
vnoremap * y/<c-r>"<cr>
" replace with r
nnoremap r *Ncgn
" replace highlighted text
vmap r *Ncgn

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
" select current word and copy to clipboard with Y in normal mode
nmap Y viwY
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
set foldmethod=indent

" leader stuff
let mapleader=" "
nnoremap <leader>w :w<cr>
nnoremap <silent> mm :noh<cr>
nnoremap <leader>s :mksession!<CR>

" escape is far
inoremap jk <esc>
inoremap jj <esc>
inoremap Jk <esc>
inoremap JK <esc>
inoremap Jj <esc>
inoremap JJ <esc>

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
    autocmd BufEnter *.go  setlocal noexpandtab colorcolumn=120
    autocmd BufEnter *.tmpl set filetype=go
    autocmd BufEnter *.tmpl setlocal noexpandtab colorcolumn=120
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
    autocmd BufEnter *.js setlocal tabstop=2
    autocmd BufEnter *.js setlocal shiftwidth=2
    autocmd BufEnter *.js setlocal softtabstop=2
    autocmd BufEnter *.tsx setlocal tabstop=2
    autocmd BufEnter *.tsx setlocal shiftwidth=2
    autocmd BufEnter *.tsx setlocal softtabstop=2
    autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=javascript.jsx
augroup END

" ================ PLUGINS ================

" git commands on current file
map <leader>d :GitGutterLineHighlightsToggle<cr>
map <leader>s :Gstatus<cr>
map <leader>o :GBrowse<cr>
map <leader>b :Git blame<cr>
map <leader>n ]c
map <leader>N [c

" ctrlp
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_cmd='CtrlP :pwd'
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
let g:airline#extensions#tabline#tab_nr_type = 2
"
let g:airline_section_a = airline#section#create(['mode'])
let g:airline_section_b = ''  " hide version control
let g:airline_section_c = airline#section#create(['hunks','%f'])
let g:airline_section_d = ''
let g:airline_section_x = ''  " hide filetype
let g:airline_section_y = '%{taghelper#curtag()}'
let g:airline_section_z = airline#section#create_right(['linenr', '%c'])

" replace file encoding with tag
autocmd VimEnter * highlight airline_tabfill ctermbg=237

" vimux
:command Vp VimuxPromptCommand

" pymode
let g:pymode_python = 'python3'
let g:pymode_doc = 0
let g:pymode_rope = 1
let g:pymode_run = 1
let g:pymode_rope_goto_definition_bind = '<C-t>'
let g:pymode_rope_completion = 0
let g:pymode_rope_regenerate_on_write = 0
let g:pymode_breakpoint_bind = ''
let g:pymode_rope_show_doc_bind = ''

" ignore too complex lint error
let g:pymode_lint_ignore = ["C901"]

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

" let g:pymode_lint_checkers = ['black']
let g:pymode_lint = 0
let g:pymode_lint_todo_symbol = 'W'
let g:pymode_lint_comment_symbol = 'C'
let g:pymode_lint_visual_symbol = 'R'
let g:pymode_lint_error_symbol = 'E'
let g:pymode_lint_info_symbol = 'I'
let g:pymode_lint_pyflakes_symbol = 'F'

" " autosave delay, cursorhold trigger, default: 4000ms
setl updatetime=200
" highlight the word under cursor (CursorMoved is inperformant)
highlight WordUnderCursor ctermbg=238
autocmd CursorHold * call HighlightCursorWord()
function! HighlightCursorWord()
    " if hlsearch is active, don't overwrite it!
    let search = getreg('/')
    let cword = expand('<cword>')
    if match(cword, search) == -1
        exe printf('match WordUnderCursor /\V\<%s\>/', escape(cword, '/\'))
    endif
endfunction
nnoremap <c-d> *

" Search and Ack
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
  let g:ackprg = 'ag --vimgrep'
endif
cnoreabbrev Ack Ack!
nnoremap <Leader>g :Ack!<CR>
nnoremap <Leader>h :Ack!<Space>

" nnoremap Q :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" bind \ (backward slash) to grep shortcut
" command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
" nnoremap \ :Ag<SPACE>
"

" golang
map <leader>c :GoBuild<cr>
let g:go_doc_keywordprg_enabled = 0
