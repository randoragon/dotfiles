#!/bin/sh

# Moves a floating node "smoothly" in an efficient way - by entering a
# loop which moves and sleeps until some designated key is let go of.
# Works both on tiled and floating windows -- tiled will simply swap in
# the appropriate cardinal direction.
#
# Usage:
#       smooth_move.sh AXIS AMOUNT KEY
#
# AXIS is either "h" or "v"
# AMOUNT is the speed in pixels per 0.025s - can be negative
# KEY is the keysym xkeycheck will listen for, see xkeycheck(1)
#
# Dependencies:
# - xkeycheck (https://github.com/randoragon/xkeycheck)

dir="$1"
amount="$2"

# If another process is already doing the same motion, abort.
# This is necessary, because sxhkd does not support running
# commands on "press only".
for pid in $(pgrep -f "\bsmooth_move.sh $dir"); do
    [ "$pid" -ne $$ ] && exit
done

if bspc query -N -n focused.floating >/dev/null; then
    key="$3"
    xkeycheck "$key" || exit 2

    case "$dir" in
        h) cmd="-v $amount 0" ;;
        v) cmd="-v 0 $amount" ;;
        *) exit 1 ;;
    esac

    # Resize until key is let go of
    while xkeycheck "$key"; do
        bspc node $cmd
        sleep 0.025
    done
else
    case "$dir$amount" in
        h+*) bspc node -s east.!focused  ;;
        h-*) bspc node -s west.!focused  ;;
        v+*) bspc node -s south.!focused ;;
        v-*) bspc node -s north.!focused ;;
    esac
fi
