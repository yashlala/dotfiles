# 
# ~/.config/zsh/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='%F{yellow}[%c %(?..%F{green})%#%F{yellow}]%f '

HISTFILE=~/.local/share/zsh/histfile
HISTSIZE=5000
SAVEHIST=5000
setopt appendhistory histignoredups histignorespace 

setopt nobeep extendedglob
# Enable vi keys
bindkey -v

# The following line was added by compinstall
zstyle :compinstall filename '/home/lala/.config/zsh/.zshrc'

#########################################
# Modules
#########################################
# Enable completions
autoload -Uz compinit
compinit
setopt COMPLETE_ALIASES

# Enable Calculator
autoload -Uz zcalc

#########################################
# Aliases
#########################################
alias quit='exit'
alias lkj='echo sudo `fc -ln -1` && sudo `fc -ln -1`'
alias hibernate='systemctl hibernate' 
alias connect='sudo netctl-auto switch-to' 
alias battery='acpi -b'

alias info='info --vi-keys'
alias fortune='fortune -a'

alias grep='grep --color=auto'
alias grepi='grep -i --color=auto' 
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias ls='ls --color=auto'
alias la='ls -A'
alias ll='ls -lh'
alias lal='ls -AlhF'

ms() { cd "$@" && ls; }
ma() { cd "$@" && ls -A; }
