#!/bin/sh

userresources=$HOME/.Xresources

if [ -f "$userresources" ]; then 


	xrdb -merge "$userresources"
fi


# Autostart applications are within i3 config file for modularity. 
exec i3
