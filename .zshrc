
# added by Anaconda3 2.4.1 installer
export PATH="/Users/Elliott/anaconda/bin:$PATH"

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

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

