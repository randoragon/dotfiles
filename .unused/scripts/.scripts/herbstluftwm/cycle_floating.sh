#!/bin/sh

# Cycles between all floating clients in the
# current tag.
#
# Usage:
#     cycle_floating.sh DIRECTION
# DIRECTION is a number by which to cycle, can be negative.

hc () {
    herbstclient "$@"
}

list="$(hc sprintf X '--tag=%s' tags.focus.name list_clients X --floating)"
[ -z "$list" ] && exit

# Filter out invisible windows and find the
# currently focused window (if any)
filtered=
curr="$(hc get_attr clients.focus.winid)"
idx=
max=0
for wid in $list; do
    hc compare clients."$wid".visible = 1 && {
        filtered="$filtered $wid"
        [ -z "$idx" ] && [ "$curr" = "$wid" ] && idx=$max
        max=$((max + 1))
    }
done
[ -z "$filtered" ] && exit
filtered="${filtered# }"

# If no window is focused, always focus the first one
[ -z "$idx" ] && hc jumpto "${filtered%% *}" && exit

idx=$(((idx + $1 + max) % max))
hc jumpto "$(printf %s "$filtered" | cut -d' ' -f$((idx + 1)))"
