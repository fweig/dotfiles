# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# append to the history file, don't overwrite it
shopt -s histappend

#Disable 'Suspend output'
stty -ixon
stty -ixoff

# Source system-wide profile to ensure proper environment setup
[[ -f /etc/profile ]] && source /etc/profile

# Autoload ssh keys
eval $(ssh-agent) >/dev/null 2>&1
ssh-add ~/.ssh/id >/dev/null 2>&1

git_ps1=/usr/share/git-core/contrib/completion/git-prompt.sh
[[ -f $git_ps1 ]] && source $git_ps1


op() {
    nohup xdg-open $@ & >/dev/null 2>&1
}

# Environment
export TERM=xterm-256color
export MAKEFLAGS="-j$(nproc)"

PATH+=":/sbin"

# Shell prompt
GIT_PS1_SHOWDIRTYSTATE='y'
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\[\e[91m\]$(__git_ps1)\[\033[00m\]\$ '

# Look for local configurations
[ -f ~/.bashrc.local ] && source ~/.bashrc.local

# Look for common configurations
[ -f ~/.profile ] && source ~/.profile

