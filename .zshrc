
alias ls="ls -G"
alias ll="ls -l"
alias psef="ps -ef | grep"
alias ns="npm start"
alias ni="npm install"


alias ga="git add ."
alias gc="git commit -m"
alias gp="git push origin master"
alias gph="git push heroku master"
alias gs="git status"
alias gpull="git pull origin master"

autoload -U colors
colors
export PS1="${fg[green]}%m:${fg[yellow]}%1~ ${fg[cyan]}%n${fg[white]}$ "
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

