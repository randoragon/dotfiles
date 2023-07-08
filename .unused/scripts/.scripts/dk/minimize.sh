#!/bin/sh

# "Minimizes" the currently focused window. The window is not actually
# minimized, it gets sent to a dedicated workspace.
#
# Usage:
#       minimize.sh

FILE="${TMPDIR:-/tmp}/dkwm.$(whoami).minimized"
MINIMIZE_WS=_sp

# File format (tab-separated):
# workspace    time    winid    class:instance    title...
state="$(dkcmd status type=full num=1)"
wid="$(echo "$state" | rg -o -r \$1 "^active_window: (.*)")"
[ -z "$wid" ] && exit
ws="$(echo "$state" | rg -o -r \$1 '^workspaces: .*\*[^:]+:([^:]+)')"
time="$(date +%T)"
fullclass="$(xprop -id "$wid" | sed -n 's/^WM_CLASS(STRING) = //p')"
class="$(echo "$fullclass" | cut -d\" -f4)"
instance="$(echo "$fullclass" | cut -d\" -f2)"
title="$(xdotool getwindowname "$wid")"

printf '%s\t%s\t%s\t%s\t%s\n' \
    "$ws"                     \
    "$time"                   \
    "$wid"                    \
    "$class:$instance"        \
    "$title"                  \
    >>"$FILE"

dkcmd ws send "$wid" "$MINIMIZE_WS"
