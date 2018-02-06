
alias ls="ls -G"
alias ll="ls -l"
alias psef="ps -ef | grep"
alias ns="npm start"
alias ni="npm install"

alias g="git"
alias ga="git add ."
alias gc="git commit -m"
alias gca="git commit --amend"
alias gco="git checkout"
alias gr="git rebase -i"
alias gp="git push origin master"
alias gs="git status"
alias gl="git lol"
alias gd="git diff"
alias gpull="git pull origin master"

export PS1="\[\033[32m\]\h:\[\033[33;1m\]\W\[\033[m\] \[\033[36m\]\u\[\033[m\]\n\[\033[31m\]$\[\033[m\] "
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

export VISUAL=vim
export EDITOR="$VISUAL"


