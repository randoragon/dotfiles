#!/bin/sh

# HerbstluftWM script to move floating windows by a
# constant number of pixels, or throw them against
# the edges (or to the center) of the monitor.
#
# Usage:
#    move_window.sh ACTION [PIXELS]
#
# Actions:
#   - n  - move  north by PIXELS (default 5)
#   - e  - move  east  by PIXELS (default 5)
#   - s  - move  south by PIXELS (default 5)
#   - w  - move  west  by PIXELS (default 5)
#   - nt - throw north
#   - et - throw east
#   - st - throw south
#   - wt - throw west
#   - c  - center

# Window borders. Much cheaper to hardcode than query.
BORDER=2

# WM status bar height (top)
BAR_H=20

hc () {
    herbstclient "$@"
}

# Lock hlwm
hc lock
hc lock_tag

# Fetch window x, y, w, h
geom="$(hc get_attr clients.focus.content_geometry)"
[ -z "$geom" ] && exit
wwh="${geom%%[+-]*}"
wxy="$(printf %s "$geom" | cut -b"$((${#wwh} + 1))"-)"
ww="${wwh%x*}"
wh="${wwh#*x}"
tx="${wxy%[+-]*}"
ty="$(printf %s "$wxy" | cut -b"$((${#tx} + 1))"-)"

# Get monitor dimensions
geom="$(hc get_attr monitors.focus.geometry)"
swh="${geom%%[+-]*}"
sw="${swh%x*}"
sh="${swh#*x}"

# Default movement amount (in pixels)
AMOUNT=30

case "$1" in
    n)
        ty=$((ty - ${2:-$AMOUNT}))
        ;;
    nt)
        ty=$((BAR_H + BORDER))
        ;;
    e)
        tx=$((tx + ${2:-$AMOUNT}))
        ;;
    et)
        tx=$((sw - ww - BORDER))
        ;;
    s)
        ty=$((ty + ${2:-$AMOUNT}))
        ;;
    st)
        ty=$((sh - wh - BORDER))
        ;;
    w)
        tx=$((tx - ${2:-$AMOUNT}))
        ;;
    wt)
        tx=$BORDER
        ;;
    c)
        tx=$(((sw - ww) / 2))
        ty=$(((sh - wh) / 2))
        ;;
    *)
        echo 'wm-throw: invalid direction (must be one of: north, east, south, west, center)' >&2
        exit 1
esac

wid="$(xdo id)"
xdo move -x "${tx#+}" -y "${ty#+}" "$wid"
xdo activate "$wid"

# Unlock hlwm
hc unlock_tag
hc unlock
