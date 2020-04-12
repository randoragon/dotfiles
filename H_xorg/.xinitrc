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

# Start the window/display manager
exec i3
