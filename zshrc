setopt NO_BEEP NO_AUTOLIST BASH_AUTOLIST NO_MENUCOMPLETE
autoload -Uz compinit && compinit

# Load version control info
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

# Configure vcs_info
zstyle ':vcs_info:git:*' formats ' (%b)'

# Set the prompt
PROMPT='${vcs_info_msg_0_}%f\$ '

parse_git_branch() {
    git symbolic-ref --short HEAD 2> /dev/null | sed -E 's/(.+)/ (\1)/g'
}

setopt PROMPT_SUBST
PROMPT='%B%F{green}%n@%m%f%b:%B%F{blue}%1~%f%b%F{red}%{%F{green}%}$(parse_git_branch)%{%F{none}%} $ '

[[ -f ~/.profile ]] && emulate sh -c 'source ~/.profile'
