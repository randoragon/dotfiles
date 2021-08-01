#!/usr/bin/sh

# This script is started in the background right before dwm initializes itself.

dwmblocks &
st -g 100x30 -n s_term &

# Run startup code common for all graphical sessions
xprofile="$HOME/.config/X11/xprofile"
[ -f "$xprofile" ] && . "$xprofile"

