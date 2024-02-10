#!/bin/sh

# EWMH script to throw floating windows against
# the edges (or to the center) of the monitor.
# Should work on any EWMH-compliant WM.
#
# Dependencies:
# - xdotool
# - xdpyinfo
# - wmctrl
#
# Usage:
#    throw_window.sh ACTION
#
# Actions:
#   - n  - throw north
#   - e  - throw east
#   - s  - throw south
#   - w  - throw west
#   - c  - center
#
# PIXELS can be a negative number.

BORDER=2  # Window borders
BAR_H=19  # Top padding (status bar height)

# Fetch window geometry
# shellcheck disable=SC2046
eval $(xdotool getactivewindow getwindowgeometry --shell)

# Get monitor dimensions
geom="$(xdpyinfo | awk '/dimensions:/ { print $2 ; exit }')"
sw="${geom%x*}"
sh="${geom#*x}"

case "$1" in
    n)
        X=-1
        Y=$BAR_H
        ;;
    e)
        X=$((sw - WIDTH - 2*BORDER))
        Y=-1
        ;;
    s)
        X=-1
        Y=$((sh - HEIGHT - 2*BORDER))
        ;;
    w)
        X=0
        Y=-1
        ;;
    c)
        X=$(((sw - WIDTH - 2*BORDER) / 2))
        Y=$(((sh - HEIGHT - 2*BORDER) / 2))
        ;;
    *) exit 1
esac

WIDTH=-1
HEIGHT=-1
wmctrl -i -r "$WINDOW" -e 0,"$X","$Y","$WIDTH","$HEIGHT"
