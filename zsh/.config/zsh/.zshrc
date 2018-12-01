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

setopt nobeep autocd extendedglob
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

# Enable help
autoload -Uz run-help
autoload -Uz run-help-git
unalias run-help
alias help=run-help

#########################################
# Aliases
#########################################
alias quit='exit'
alias lkj='echo `fc -ln -1` && sudo `fc -ln -1`'

alias info='info --vi-keys'
alias fortune='fortune -a'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias ls='ls --color=auto'
alias ll='ls -lh'
alias lal='ls -AlFh'
alias la='ls -A'

ms() { cd "$@" && ls; }
ma() { cd "$@" && ls -A; }
