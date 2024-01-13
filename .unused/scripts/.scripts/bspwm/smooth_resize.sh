#!/bin/sh

# Resizes a node "smoothly" in an efficient way - by first locating
# the right node, then entering a loop which resizes and sleeps until
# some designated key is let go of. Works both on tiled and floating.
#
# Usage:
#       smooth_resize.sh AXIS AMOUNT KEY
#
# AXIS is either "h" or "v"
# AMOUNT is the new ratio: a value between 0 and 1 OR +|-pixels.
# KEY is the keysym xkeycheck will listen for, see xkeycheck(1)
#
# Dependencies:
# - xkeycheck (https://github.com/randoragon/xkeycheck)

dir="$1"
[ "$dir" != h ] && [ "$dir" != v ] && exit 1
amount="$2"

# If another process is already doing the same resize, abort.
# This is necessary, because sxhkd does not support running
# commands on "press only".
for pid in $(pgrep -f "\bsmooth_resize\.sh $dir"); do
    [ "$pid" -ne $$ ] && exit
done

key="$3"
xkeycheck "$key" || exit 2

# Determine the bspc node command to run in the loop
if bspc query -N -n focused.floating >/dev/null; then
    if [ "$dir" = h ]; then
        cmd="-z right $amount 0"
    else
        cmd="-z bottom 0 $amount"
    fi
else
    # Locate the right parent node
    node=@parent
    while bspc query -N -d -n "$node" >/dev/null; do
        bspc query -N -d -n "$node.vertical" >/dev/null && \
            splittype=v || splittype=h
        [ $splittype != "$dir" ] && break
        node="$node/parent"
    done
    cmd="$node -r $amount"
fi

# Resize until key is let go of
while xkeycheck "$key"; do
    bspc node $cmd
    sleep 0.025
done
