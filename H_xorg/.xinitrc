#!/bin/sh

# This file is run automatically when an X session starts
# via running "startx" or "xinit".
#
# There is another file, ".xprofile", which also contains 
# important session startup code, but that file is also
# automatically executed by common display managers,
# so to prevent code redundancy it is sourced here.
[ -f "$HOME/.xprofile" ] && . "$HOME/.xprofile"


# Source script files from xinitrc.d directory
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# Start the window/display manager
exec i3
