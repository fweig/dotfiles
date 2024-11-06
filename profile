# Variables
export EDITOR='nvim'

# Alias for unix
alias rsync='rsync -a --progress'
alias vi='nvim'
alias tmux="tmux -u"
alias ls="ls --color=auto"
alias ll="ls -lAF"
alias la="ls -A"
alias l="ls -CF"

alias nvim-qt="nvim-qt --no-ext-tabline"

# Alias for useful shorthands
alias bake="make -sCbuild"
alias bt="gdb -batch -ex=r -ex=bt --args"