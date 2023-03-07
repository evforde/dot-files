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
alias grepnt='grep --exclude="*/test/*"'
alias agnt='ag --ignore=*test* --ignore=*migrations*'

alias shell="./manage.py shell"

alias mctags="ctags -R -f ./.tags ."
alias rmpyc="find . -name "*.pyc" -exec rm {} \;"

alias g="git"
alias ga="git add"
alias gb="git branch -v"
alias gc="git commit -m"
alias gca="git commit --amend --no-edit"
alias gcam="git commit --amend"
alias gco="git checkout"
alias gcom="git checkout origin/master"
alias gcp="git cherry-pick"
alias gr="git rebase -i"
alias grh="git rebase -i HEAD"
alias gra="git rebase --abort"
alias grc="git rebase --continue"
alias gre="git rebase --edit-todo"
alias grm="git rebase -i origin/master"
alias gfp="git fetch -p"
alias gp="git push origin master"
alias gpo="git push origin"
alias gs="git status -s"
alias gss="git status"
alias gsf="git diff --name-only HEAD^ HEAD"
alias gst="git stash"
alias gstp="git stash pop"
alias gll="git lol"
alias gl="git lol -n 20"
alias gd="git diff"
alias gds="git diff --name-status"
alias gdm="git diff origin/master"
alias gpl="git pull origin master --rebase"
alias gsub="git submodule update"
alias gsom="git rev-parse origin/master | tee >(pbcopy)"

alias tmux="TERM=screen-256color-bce tmux"

export PS1="\[\033[32m\]\D{%H:%M:%S} \[\033[35m\]\h:\[\033[33;1m\]\W\[\033[m\] \[\033[36m\]\u\[\033[m\]\n\[\033[31m\]$\[\033[m\] "
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

export VISUAL=vim
export EDITOR="$VISUAL"

export HISTCONTROL=ignoreboth:erasedups

export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/go/bin/

if [ $ITERM_SESSION_ID ]; then
  export PROMPT_COMMAND='echo -ne "\033];${PWD##*/}\007"; '
fi
eval "$(/opt/homebrew/bin/brew shellenv)"
. "$HOME/.cargo/env"

alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
export PGDATA=/opt/homebrew/var/postgres start

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

source ~/dot-files/.fp_rc

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
