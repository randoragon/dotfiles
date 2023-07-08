#!/bin/sh

# This script simulates more intuitive resizing of tiled windows.
#
# Usage:
#       tiled_resize.sh AXIS AMOUNT
#
# AXIS is either "h" or "v"
# AMOUNT is the new ratio: a value between 0 and 1 OR +|-pixels.

dir="$1"
[ "$dir" != h ] && [ "$dir" != v ] && exit 1
amount="$2"

node=@parent
while bspc query -N -d -n "$node" >/dev/null; do
    bspc query -N -d -n "$node.vertical" >/dev/null && \
        splittype=v || splittype=h
    [ $splittype != "$dir" ] && {
        bspc node "$node" -r "$amount"
        exit
    }
    node="$node/parent"
done
