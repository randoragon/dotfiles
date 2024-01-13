#!/bin/sh

# EWMH script to throw floating windows against
# the edges (or to the center) of the monitor.
# Should work on any EWMH-compliant WM.
#
# Dependencies:
# - xdotool
# - xdpyinfo
#
# Usage:
#    throw_window.sh ACTION [PIXELS]
#
# Actions:
#   - n  - throw north
#   - e  - throw east
#   - s  - throw south
#   - w  - throw west
#   - c  - center
#
# PIXELS can be a negative number.

BORDER=2 # Window borders
BAR_H=20 # Top padding (status bar height)

# Fetch window geometry
eval $(xdotool getactivewindow getwindowgeometry --shell)

# Get monitor dimensions
geom="$(xdpyinfo | awk '/dimensions:/ { print $2 ; exit }')"
sw="${geom%x*}"
sh="${geom#*x}"

case "$1" in
    n)
        Y=$BAR_H
        ;;
    e)
        X=$((sw - WIDTH - 2*BORDER))
        ;;
    s)
        Y=$((sh - HEIGHT - 2*BORDER))
        ;;
    w)
        X=0
        ;;
    c)
        X=$(((sw - WIDTH) / 2))
        Y=$(((sh - HEIGHT) / 2))
        ;;
    *) exit 1
esac

xdotool windowmove "$WINDOW" "$X" "$Y" \
        windowsize "$WINDOW" "$WIDTH" "$HEIGHT"
