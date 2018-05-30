
alias ls="ls -G"
alias ll="ls -l"
alias grep="grep --color=auto --exclude=\*.{swp} -I"

alias g="git"
alias gb="git branch"
alias ga="git add ."
alias gc="git commit -m"
alias gca="git commit --amend"
alias gco="git checkout"
alias gr="git rebase -i"
alias gp="git push origin master"
alias gs="git status"
alias gst="git stash"
alias gl="git lol"
alias gd="git diff"
alias gpl="git pull origin master"

autoload -U colors
colors
export PS1="${fg[green]}%D{%H:%M:%S} ${fg[magenta]}%m:${fg[yellow]}%1~ ${fg[cyan]}%n"$'\n'"${fg[red]}$ ${fg[white]}"
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

