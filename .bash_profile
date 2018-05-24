
alias ls="ls -G"
alias ll="ls -l"
alias grep="grep --color=auto"

alias mctags="ctags -R -f ./.tags ."

alias g="git"
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

export PS1="\[\033[32m\]\D{%H:%M:%S} \[\033[35m\]\h:\[\033[33;1m\]\W\[\033[m\] \[\033[36m\]\u\[\033[m\]\n\[\033[31m\]$\[\033[m\] "
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

export VISUAL=vim
export EDITOR="$VISUAL"

#
# ROBINHOOD STUFF
#

export PATH="$PATH:/usr/local/phabricator/arcanist/bin/" 

export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

# Command line gitk-like viewer
alias gitk-text='git log --graph --pretty="tformat:%C(yellow)%h%Creset %Cgreen(%ar)%Creset %C(bold blue)<%an>%Creset %C(red)%d%Creset %s"'

# Automatically activate Git projects' virtual environments based on the
# directory name of the project. Virtual environment name can be overridden
# by placing a .venv file in the project root with a virtualenv name in it
# http://hmarr.com/2010/jan/19/making-virtualenv-play-nice-with-git/
function workon_cwd {
    # Check that this is a Git repo
    GIT_DIR=`git rev-parse --git-dir 2> /dev/null`
    if [ $? == 0 ]; then
        # Find the repo root and check for virtualenv name override
        GIT_DIR=`\cd $GIT_DIR; pwd`
        PROJECT_ROOT=`dirname "$GIT_DIR"`
        ENV_NAME=`basename "$PROJECT_ROOT"`
        if [ -f "$PROJECT_ROOT/.venv" ]; then
            ENV_NAME=`cat "$PROJECT_ROOT/.venv"`
        fi
        # Activate the environment only if it is not already active
        if [ "$VIRTUAL_ENV" != "$WORKON_HOME/$ENV_NAME" ]; then
            if [ -e "$WORKON_HOME/$ENV_NAME/bin/activate" ]; then
                workon "$ENV_NAME" && export CD_VIRTUAL_ENV="$ENV_NAME"
            fi
        fi
    elif [ $CD_VIRTUAL_ENV ]; then
        # We've just left the repo, deactivate the environment
        # Note: this only happens if the virtualenv was activated automatically
        deactivate && unset CD_VIRTUAL_ENV
    fi
}
# New cd function that does the virtualenv magic
function venv_cd {
    cd "$@" && workon_cwd
}
alias cd="venv_cd"

# Delete all the old .pyc files that could be causing you errors
alias clean_pyc="find . -name '*.pyc' -delete"

# Add arcanist to path (Change 'arc' to where you installed arcanist)
export PATH="$PATH:~/arc/arcanist/bin"
# Always add coverage if running arc diff
alias ad="arc diff --coverage"
