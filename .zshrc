
alias ls="ls -G"
alias ll="ls -lh"
alias grep="grep --color=auto --exclude=\*.{swp} -I"

alias g="git"
alias ga="git add"
alias gb="git branch"
alias gc="git commit -m"
alias gca="git commit --amend"
alias gco="git checkout"
alias gr="git rebase -i"
alias grc="git rebase --continue"
alias gp="git push origin master"
alias gs="git status"
alias gst="git stash"
alias gstp="git stash pop"
alias gl="git lol"
alias gd="git diff"
alias gdm="git diff master"
alias gpl="git pull origin master"

autoload -U colors
colors
export PS1="${fg[green]}%D{%H:%M:%S} ${fg[magenta]}%m:${fg[yellow]}%1~ ${fg[cyan]}%n"$'\n'"${fg[red]}$ ${fg[white]}"
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
