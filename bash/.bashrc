#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\e[33m\][\u \W]\$ \[\e[00m\]'


color_prompt=yes
force_color_prompt=yes

HISTSIZE=-1
HISTFILESIZE=-1

# ignore consecutive duplicated entries and lines with a leading space
HISTCONTROL=ignoreboth

# append to history file, don't overwrite it
shopt -s histappend


#########################################
# Autostart
#########################################

#########################################
# Aliases
#########################################
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ls='ls --color=auto'
alias ll='ls -lh'
alias lal='ls -AlFh'
alias la='ls -A'

alias quit='exit'
alias lkj='sudo $(history -p \!\!)'

alias h='wikicurses'
alias hh='wikicurses --wiki arch'

alias info='info --vi-keys'
alias calcurse='calcurse --directory ~/.config/calcurse'

# some useful navigational functions
function ms () { 
	cd "$@" && ls 
}
function ma () { 
	cd "$@" && ls -A 
}
