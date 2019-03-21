# Start vim with obsession when no file provided
function vim() {
  if test $# -gt 0; then
    env vim "$@"
  elif test -f Session.vim; then
    env vim -S
  else
    env vim -c Obsession
  fi
}

alias ls="ls -G"
alias ll="ls -lh"
alias grep='grep --color=auto --exclude=\*.{swp} -I --exclude="*.git/*" --exclude="*cover/*" --exclude="*env/*" --exclude="*.tags"'
alias ggrep="git grep --color=auto -I"
alias grepnt='grep --exclude="*/tests/*"'

alias shell="./manage.py shell"

alias mctags="ctags -R -f ./.tags ."

alias g="git"
alias ga="git add"
alias gb="git branch"
alias gc="git commit -m"
alias gca="git commit --amend"
alias gco="git checkout"
alias gr="git rebase -i"
alias grc="git rebase --continue"
alias grm="git rebase -i origin/master"
alias gp="git push origin master"
alias gpo="git push origin"
alias gs="git status"
alias gst="git stash"
alias gstp="git stash pop"
alias gl="git lol"
alias gd="git diff"
alias gdm="git diff master"
alias gpl="git pull origin master --rebase"
alias gsub="git submodule update"

alias tmux="TERM=screen-256color-bce tmux"

export PS1="\[\033[32m\]\D{%H:%M:%S} \[\033[35m\]\h:\[\033[33;1m\]\W\[\033[m\] \[\033[36m\]\u\[\033[m\]\n\[\033[31m\]$\[\033[m\] "
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

export VISUAL=vim
export EDITOR="$VISUAL"

export HISTCONTROL=ignoreboth:erasedups
