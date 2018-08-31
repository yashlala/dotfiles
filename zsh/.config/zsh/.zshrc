# 
# ~/.config/zsh/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='%F{yellow}[%c %#]%f '

HISTFILE=~/.local/share/zsh/histfile
HISTSIZE=5000
SAVEHIST=5000
setopt appendhistory histignoredups histignorespace 

setopt nobeep autocd extendedglob
bindkey -v

# The following lines were added by compinstall
zstyle :compinstall filename '/home/lala/.config/zsh/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#########################################
# Aliases
#########################################
alias quit='exit'
alias lkj='echo `fc -ln -1` && sudo `fc -ln -1`'
ms() { cd "$@" && ls; }
ma() {cd "$@" && ls -A; }

alias info='info --vi-keys'
alias calcurse='calcurse --directory ~/.config/calcurse'

alias h='wikicurses'
alias hh='wikicurses --wiki arch'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ls='ls --color=auto'
alias ll='ls -lh'
alias lal='ls -AlFh'
alias la='ls -A'
