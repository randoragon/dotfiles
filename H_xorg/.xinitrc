#!/bin/sh

# This file is run automatically when an X session starts
# via running "startx" or "xinit".

# Source script files from xinitrc.d directory
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# Set keyboard layout
setxkbmap -layout pl

# Swap escape and caps lock
setxkbmap -option caps:swapescape

# Read Xresources file
[ -f "$HOME/.Xresources" ] && xrdb "$HOME/.Xresources"

# Export wacom related variables
. "$HOME/.scripts/wacom/wacom-setup"

# Setting this allows some applications to easily
# know if they're in a graphical env or a tty
export DESKTOP_SESSION=i3

# Start the window/display manager
exec i3
