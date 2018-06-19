#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

PATH=$PATH:~/code/bin

export EDITOR=nvim

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx;
fi
