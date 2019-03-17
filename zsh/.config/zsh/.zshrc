#
# ~/.config/zsh/.zshrc
#

# if not running interactively, don't do anything
[[ $- != *i* ]] && return


# configure history
setopt appendhistory histignoredups histignorespace

# configure interface
PS1='%F{yellow}[%c %(?..%F{green})%#%F{yellow}]%f '
setopt nobeep extendedglob
bindkey -v

# enable and configure completion module
autoload -Uz compinit
compinit
setopt nocomplete_aliases

# enable and configure help module
autoload -Uz run-help
unalias run-help
alias help=run-help

# aliases and functions

alias quit='exit'
alias hibernate='systemctl hibernate'
alias connect-to='sudo netctl-auto switch-to'
alias battery='acpi -b'

alias info='info --vi-keys'
alias gdb='gdb -q'
alias cgdb='cgdb -q'

alias unstow='stow -D'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grepi='grep -i --color=auto'

alias ls='ls --color=auto'
alias la='ls --color=auto -A'
alias ll='ls --color=auto -lh'
alias lal='ls --color=auto -AlhF'

alias cl='echo -ne '\''\033c'\'''

lkj() { 
	echo ${$(tput bold)}sudo $(fc -ln -1) ${$(tput sgr0)}
	eval sudo "$(fc -ln -1)"
}
ms() { cd "$@" >/dev/stdout && ls; }
ma() { cd "$@" >/dev/stdout && ls -A; }
