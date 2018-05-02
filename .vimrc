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
set showcmd
set cursorline
filetype indent on
set wildmenu
set lazyredraw
set showmatch

"search settings
set incsearch
set hlsearch

"folding
set foldenable
set foldlevelstart=10
nnoremap <space> za
set foldmethod=syntax

nnoremap B ^ "move to beginning of line
nnoremap E $ "move to end of line
nnoremap ^ <nop>
nnoremap $ <nop>

nnoremap gV `[v`]
inoremap jk <esc>
nnoremap <c-k> gt
nnoremap <c-j> gT
set virtualedit+=onemore

set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

au BufNewFile,BufRead SCons* set filetype=scons

augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
                \:call <SID>StripTrailingWhitespaces()
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END

