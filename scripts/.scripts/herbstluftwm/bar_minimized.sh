#!/bin/sh

# Displays the number of currently minimized windows.

FILE="${TMPDIR:-/tmp}/hlwm.$(whoami).minimized"
[ ! -r "$FILE" ] && echo 0 && exit

exec wc -l <"$FILE"
