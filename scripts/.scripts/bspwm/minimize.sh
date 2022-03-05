#!/bin/sh

# "Minimizes" the currently focused window. The window is not actually
# minimized, it gets sent to a dedicated desktop.
#
# Usage:
#       minimize.sh

FILE="${TMPDIR:-/tmp}/bspwm.$(whoami).minimized"
MINIMIZE_DT=_sp

# File format (tab-separated):
# desktop    time    winid    class:instance    title...
wid="$(bspc query -N -n)"
[ -z "$wid" ] && exit
desktop="$(bspc query -D -d --names)"
time="$(date +%T)"
fullclass="$(xprop -id "$wid" | sed -n 's/^WM_CLASS(STRING) = //p')"
class="$(echo "$fullclass" | cut -d\" -f4)"
instance="$(echo "$fullclass" | cut -d\" -f2)"
title="$(xdotool getwindowname "$wid")"

printf '%s\t%s\t%s\t%s\t%s\n' \
    "$desktop"                \
    "$time"                   \
    "$wid"                    \
    "$class:$instance"        \
    "$title"                  \
    >>"$FILE"

bspc node "$wid" -d "$MINIMIZE_DT"

polybar-msg hook bspwm_minimized 1
