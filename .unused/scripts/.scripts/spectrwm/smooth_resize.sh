#!/bin/sh

# Resizes a floating window "smoothly" in an efficient way - by entering a loop
# which resizes and sleeps until some designated key is let go of.
#
# Usage:
#       smooth_resize.sh AXIS PIXELS KEY
#
# AXIS is either "h" or "v"
# PIXELS is the increment (applied 60 times a second; can be negative)
# KEY is the keysym xkeycheck will listen for, see xkeycheck(1)
#
# Dependencies:
# - xkeycheck (https://github.com/randoragon/xkeycheck)

BORDER=2  # Window borders

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

# Fetch window geometry
# shellcheck disable=SC2046
eval $(xdotool getactivewindow getwindowgeometry --shell)

# Resize until key is let go of
X=$((X - BORDER))
Y=$((Y - BORDER))
while xkeycheck "$key"; do
    case "$dir" in
        h)
            WIDTH=$((WIDTH + amount))
            HEIGHT=-1
            ;;
        v)
            WIDTH=-1
            HEIGHT=$((HEIGHT + amount))
            ;;
    esac
    wmctrl -i -r "$WINDOW" -e 0,"$X","$Y","$WIDTH","$HEIGHT"
    sleep 0.01666
done
