#!/usr/bin/sh

# This script is started in the background right before dwm initializes itself.

# Run startup code common for all graphical sessions
xprofile="$HOME/.config/X11/xprofile"
[ -f "$xprofile" ] && . "$xprofile"

# Start some scratch applications that should be ready to use
st -g 155x50 -n s_term &
st -g 155x50 -n s_news -e dualboat &
