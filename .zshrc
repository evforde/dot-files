
alias ls="ls -G"
alias ll="ls -l"

alias g="git"
alias ga="git add ."
alias gc="git commit -m"
alias gca="git commit --amend"
alias gchk="git checkout"
alias gr="git rebase -i"
alias gp="git push origin master"
alias gs="git status"
alias gl="git lol"
alias gd="git diff"
alias gpull="git pull origin master"

autoload -U colors
colors
export PS1="${fg[green]}%m:${fg[yellow]}%1~ ${fg[cyan]}%n"$'\n'"${fg[red]}$ ${fg[white]}"
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

