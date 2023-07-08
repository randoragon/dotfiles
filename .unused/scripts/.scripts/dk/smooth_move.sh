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
# - ripgrep

dir="$1"
amount="$2"

# If another process is already doing the same motion, abort.
# This is necessary, because sxhkd does not support running
# commands on "press only".
for pid in $(pgrep -f "\bsmooth_move.sh $dir"); do
    [ "$pid" -ne $$ ] && exit
done

status="$(dkcmd status type=full num=1)"
wid="$(echo "$status" | rg -io -r \$1 '^windows: .*\*(0x[0-9a-f]+):')"
wininfo="$(echo "$status" | sed -n "s/^\s*$wid\b.*\"\s\+//p")"
isfloating="$(echo "$wininfo" | cut -d' ' -f8)"
if [ "$isfloating" = 1 ]; then
    key="$3"
    xkeycheck "$key" || exit 2

    case "$dir" in
        h) args="x=$amount" ;;
        v) args="y=$amount" ;;
        *) exit 1 ;;
    esac

    # Resize until key is let go of
    while xkeycheck "$key"; do
        dkcmd win "$wid" resize $args
        sleep 0.025
    done
else
    notify-send "$dir$amount"
    case "$dir$amount" in
        v+*) dkcmd win mvstack down ;;
        v-*) dkcmd win mvstack up ;;
    esac
fi
