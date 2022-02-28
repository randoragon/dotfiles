#!/bin/sh

# "Minimizes" the currently focused window. The window is not actually
# minimized, it gets sent to a dedicated tag. This is because I find
# hlwm's minimization to mess up focus sometimes.
#
# Usage:
#       minimize.sh

FILE="${TMPDIR:-/tmp}/hlwm.$(whoami).minimized"
MINIMIZE_TAG=.sp

hc () {
    herbstclient "$@"
}

# File format (tab-separated):
# tag    time    winid    class:instance    title...
wid="$(hc get_attr clients.focus.winid)"
[ -z "$wid" ] && exit
info="$(hc sprintf X "%s	$(date +%T)	$wid	%s:%s	%s" \
    clients."$wid".tag clients."$wid".class                 \
    clients."$wid".instance clients."$wid".title echo X)"

printf '%s\n' "$info" >>"$FILE"

hc move "$MINIMIZE_TAG"

polybar-msg hook hlwm_minimized 1
