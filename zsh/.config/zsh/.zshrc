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
zstyle :compinstall filename '/home/lala/.config/zsh/.zshrc'
autoload -Uz compinit
compinit
setopt COMPLETE_ALIASES

# enable calculator module
autoload -Uz zcalc


# aliases and functions

alias quit='exit'
alias hibernate='systemctl hibernate' 
alias connect='sudo netctl-auto switch-to' 
alias battery='acpi -b'

alias info='info --vi-keys'
alias fortune='fortune -a'

alias unstow='stow -D'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grepi='grep -i --color=auto' 

alias ls='ls --color=auto'
alias la='ls -A'
alias ll='ls -lh'
alias lal='ls -AlhF'

ms() { cd "$@" && ls; }
ma() { cd "$@" && ls -A; }
