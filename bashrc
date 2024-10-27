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

alias rsync='rsync -a --progress'
alias vi='nvim'
alias tmux="tmux -u"
alias ls="ls --color=auto"
alias ll="ls -lAF"
alias la="ls -A"
alias l="ls -CF"

alias nvim-qt="nvim-qt --no-ext-tabline"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

op() {
    nohup xdg-open $@ & >/dev/null 2>&1
}

export TERM=xterm-256color
export MAKEFLAGS="-j$(nproc)"
export EDITOR='nvim'

PATH+=":/sbin"

GIT_PS1_SHOWDIRTYSTATE='y'
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\[\e[91m\]$(__git_ps1)\[\033[00m\]\$ '

function load_gcc_14 {
        _gcc14_dir=$HOME/.local/gcc-14.2.0
        export CC=$_gcc14_dir/bin/gcc
        export CXX=$_gcc14_dir/bin/g++
        export LDFLAGS="${LDFLAGS} -L $_gcc14_dir/lib64 -Wl,-rpath -Wl,$_gcc14_dir/lib64"
}