#!/bin/sh

# Cycles between all clients in the focused frame.
# Extremely useful for navigating max layouts.
#
# Usage:
#     cycle_frame.sh DIRECTION
# DIRECTION is a number by which to cycle, can be negative.

hc () {
    herbstclient "$@"
}

[ -z "$1" ] && exit

info="$(hc sprintf X '%s %s'                     \
    tags.focus.tiling.focused_frame.selection    \
    tags.focus.tiling.focused_frame.client_count \
    echo X)"
idx="${info%% *}"
max="${info##* }"
hc chain , set_attr tags.focus.tiling.focused_frame.selection \
               "$(((idx + $1 + max) % max))"                  \
         , emit_hook bar_frame
