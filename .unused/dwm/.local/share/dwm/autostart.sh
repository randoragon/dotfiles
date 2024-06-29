#!/bin/sh

# This script is started in the background right before dwm initializes itself.

dwmblocks &

# Run startup code common for all graphical sessions
xprofile="$HOME/.config/X11/xprofile"
[ -f "$xprofile" ] && . "$xprofile"
