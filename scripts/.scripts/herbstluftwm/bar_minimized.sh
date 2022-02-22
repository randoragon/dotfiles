#!/bin/sh

# Displays the number of currently minimized windows.

FILE="${TMPDIR:-/tmp}/hlwm.$(whoami).minimized"

exec wc -l <"$FILE"
