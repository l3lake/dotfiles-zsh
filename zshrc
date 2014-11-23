#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# |------------------------------------------------------------------------------
# | Navigating and Listing Aliases
# |------------------------------------------------------------------------------
alias ll="ls -lhA"
#alias ls="ls -CF"
alias sl="ls"
alias lsl="ls -lhFA | less"
alias l="ls -lFh"
alias lS="ls -1FSsh"
alias la="ls -lAFh"
alias lart="ls -1Fcart"
alias ldot="ls -ld .*"
#alias ll="ls -l"
alias lr="ls -tRFh"
alias lrt="ls -1Fcrt"
alias ls="ls --color=tty"
alias lsa="ls -lah"
alias lsl="ls -lhFA | less"
alias lt="ls -ltFh"
alias fhere="find . -name "

# |------------------------------------------------------------------------------
# | System Aliases
# |------------------------------------------------------------------------------
alias s="sudo"
alias sag="sudo apt-get"
alias ag="apt-get"
alias c="clear"
alias df="df -Tha -total"
alias du="du -ach | sort -h"
alias free="free -mt"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"

# |------------------------------------------------------------------------------
# | Docker Aliases
# |------------------------------------------------------------------------------
# Get the IP address
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
alias drm="docker rm"
alias drmi="docker rmi"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias d="docker"
alias ds="docker stop"
alias dst="docker start"
alias de="docker-enter"
alias dim="docker images"
alias din="docker inspect"
alias vha="vim ~/haproxy-config/haproxy.cfg"
alias dln="docker ps --no-trunc | awk '{print $NF}'"

# Get the id of last run container example:
#   $ docker run ubuntu echo hello world
#     hello world
#   $ dl
#     19824759274
#   $ sudo docker commit `dl` helloworld
#     fdo892cf4fh
alias dl="docker ps -l -q"

# |------------------------------------------------------------------------------
# | History Settings
# |------------------------------------------------------------------------------
# Entries beginning with space aren't added into history, and duplicate
# entries will be erased (leaving the most recent entry).
export HISTCONTROL="ignorespace:erasedups"
# Give history timestamps.
export HISTTIMEFORMAT="[%F %T] "
# Lots o' history.
export HISTSIZE=10000
export HISTFILESIZE=10000

alias h="history"

# Easily re-execute the last history command.
alias r="fc -s"

# |------------------------------------------------------------------------------
# | Vim
# |------------------------------------------------------------------------------
alias v="vim"
alias svi="sudo vi"
alias svim="sudo vim"

# |------------------------------------------------------------------------------
# | Functions
# |------------------------------------------------------------------------------
# Create directory and move into it
mcd () {
  mkdir -p $1
  cd $1
}

# Docker
#function dockeruseradd () {
#  sudo groupadd docker
#  sudo gpasswd -a $1 docker
#  sudo service docker restart
#  echo ""
#  echo "" Done. $1 added to docker.
#  echo ""
#}

# |------------------------------------------------------------------------------
# | Editor
# |------------------------------------------------------------------------------
# Get the platform of the current machine
platform=$(uname);
if [[ $platform == 'Linux' ]]; then
  # Default Editor
  export EDITOR='vim'
elif [[ $platform == 'Darwin' ]]; then
  # Default Editor
  export EDITOR='atom'
  export LESSEDIT='atom ?lm+%lm -- %f'
fi

export VISUAL="$EDITOR"
alias q="$EDITOR"
alias qv="q $DOTFILES/link/.{,g}vimrc +'cd $DOTFILES'"
alias qs="q +'cd $DOTFILES'"

# |------------------------------------------------------------------------------
# | Ubuntu Specific Aliases
# |------------------------------------------------------------------------------
# Get the platform of the current machine
platform=$(uname);
if [[ $platform == 'Linux' ]]; then
  # Package management
  alias update="sudo apt-get -qq update && sudo apt-get upgrade"
  alias install="sudo apt-get install"
  alias remove="sudo apt-get remove"
  alias search="apt-cache search"
fi

# |------------------------------------------------------------------------------
# | Extract
# |------------------------------------------------------------------------------
# | https://github.com/xvoland/Extract/blob/master/extract.sh
function extract {
  if [ -z "$1" ]; then
    display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz>"
  else
    if [ -f $1 ] ; then
      NAME=${1%.*}
      mkdir $NAME && cd $NAME
      case $1 in
        *.tar.bz2)   tar xvjf ../$1    ;;
        *.tar.gz)    tar xvzf ../$1    ;;
        *.tar.xz)    tar xvJf ../$1    ;;
        *.lzma)      unlzma ../$1      ;;
        *.bz2)       bunzip2 ../$1     ;;
        *.rar)       unrar x -ad ../$1 ;;
        *.gz)        gunzip ../$1      ;;
        *.tar)       tar xvf ../$1     ;;
        *.tbz2)      tar xvjf ../$1    ;;
        *.tgz)       tar xvzf ../$1    ;;
        *.zip)       unzip ../$1       ;;
        *.Z)         uncompress ../$1  ;;
        *.7z)        7z x ../$1        ;;
        *.xz)        unxz ../$1        ;;
        *.exe)       cabextract ../$1  ;;
        *)           echo "extract: '$1' - unknown archive method" ;;
      esac
    else
      echo "$1 - file does not exist"
    fi
  fi
}
# |------------------------------------------------------------------------------
# | Git Aliases
# |------------------------------------------------------------------------------
#alias g='git'
#alias gst='git status'
#alias gd='git diff'
#alias gdc='git diff --cached'
#alias gdt='git diff-tree --no-commit-id --name-only -r'
#alias gl='git pull'
#alias gup='git pull --rebase'
#alias gp='git push'
#alias gd='git diff'
## gdv() { git diff -w "$@" | view - }
#alias gdt='git difftool'
#alias gc='git commit -v'
#alias gc!='git commit -v --amend'
#alias gca='git commit -v -a'
#alias gca!='git commit -v -a --amend'
#alias gcmsg='git commit -m'
#alias gco='git checkout'
#alias gcm='git checkout master'
#alias gr='git remote'
#alias grv='git remote -v'
#alias grmv='git remote rename'
#alias grrm='git remote remove'
#alias grset='git remote set-url'
#alias grup='git remote update'
#alias grbi='git rebase -i'
#alias grbc='git rebase --continue'
#alias grba='git rebase --abort'
#alias gb='git branch'
#alias gba='git branch -a'
#alias gbr='git branch --remote'
#alias gcount='git shortlog -sn'
#alias gcl='git config --list'
#alias gcp='git cherry-pick'
#alias glg='git log --stat --max-count=10'
#alias glgg='git log --graph --max-count=10'
#alias glgga='git log --graph --decorate --all'
#alias glo='git log --oneline --decorate --color'
#alias glog='git log --oneline --decorate --color --graph'
#alias gss='git status -s'
#alias ga='git add'
#alias gap='git add --patch'
#alias gm='git merge'
#alias grh='git reset HEAD'
#alias grhh='git reset HEAD --hard'
#alias gclean='git reset --hard && git clean -dfx'
#alias gwc='git whatchanged -p --abbrev-commit --pretty=medium'
#
## Sign and verify commits with GPG
#alias gcs='git commit -S'
#alias gsps='git show --pretty=short --show-signature'
#
## Sign and verify tags with GPG
#alias gts='git tag -s'
#alias gvt='git verify-tag'
#
##remove the gf alias
##alias gf='git ls-files | grep'
#
#alias gpoat='git push origin --all && git push origin --tags'
#alias gmt='git mergetool --no-prompt'
#
#alias gg='git gui citool'
#alias gga='git gui citool --amend'
#alias gk='gitk --all --branches'
#
#alias gsts='git stash show --text'
#alias gsta='git stash'
#alias gstp='git stash pop'
#alias gstd='git stash drop'
#
## Will cd into the top of the current repository
## or submodule.
#alias grt='cd $(git rev-parse --show-toplevel || echo ".")'
#
## Git and svn mix
#alias git-svn-dcommit-push='git svn dcommit && git push github master:svntrunk'
#
#alias gsr='git svn rebase'
#alias gsd='git svn dcommit'
##
## Will return the current branch name
## Usage example: git pull origin $(current_branch)
##
#function current_branch() {
#  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
#  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
#  echo ${ref#refs/heads/}
#}
#
#function current_repository() {
#  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
#  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
#  echo $(git remote -v | cut -d':' -f 2)
#}
#
## these aliases take advantage of the previous function
#alias ggpull='git pull origin $(current_branch)'
#alias ggpur='git pull --rebase origin $(current_branch)'
#alias ggpush='git push origin $(current_branch)'
#alias ggpnp='git pull origin $(current_branch) && git push origin $(current_branch)'
#
## Pretty log messages
#function _git_log_prettily(){
#  if ! [ -z $1 ]; then
#    git log --pretty=$1
#  fi
#}
#alias glp="_git_log_prettily"
#
## Work In Progress (wip)
## These features allow to pause a branch development and switch to another one (wip)
## When you want to go back to work, just unwip it
##
## This function return a warning if the current branch is a wip
#function work_in_progress() {
#  if $(git log -n 1 2>/dev/null | grep -q -c "\-\-wip\-\-"); then
#    echo "WIP!!"
#  fi
#}
## these alias commit and uncomit wip branches
#alias gwip='git add -A; git ls-files --deleted -z | xargs -r0 git rm; git commit -m "--wip--"'
#alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
#
## these alias ignore changes to file
#alias gignore='git update-index --assume-unchanged'
#alias gunignore='git update-index --no-assume-unchanged'
## list temporarily ignored files
#alias gignored='git ls-files -v | grep "^[[:lower:]]"'
#
