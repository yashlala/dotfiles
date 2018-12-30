#!/bin/sh

# Not sourced by DM, only on manual xinit/startx call. 
# Make sure this is before the 'exec' command or it won't be sourced by the window manager.


[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile
