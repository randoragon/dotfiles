#!/bin/sh

# HerbstluftWM script to move/resize floating windows
# by a constant number of pixels, or throw them against
# the edges (or to the center) of the monitor.
#
# Usage:
#    warp_window.sh ACTION [PIXELS]
#
# Actions:
#   - n  - move north by PIXELS (default 5)
#   - e  - move east  by PIXELS (default 5)
#   - s  - move south by PIXELS (default 5)
#   - w  - move west  by PIXELS (default 5)
#   - nt - throw north
#   - et - throw east
#   - st - throw south
#   - wt - throw west
#   - c  - center
#   - nr - resize north by PIXELS
#   - er - resize east  by PIXELS
#   - sr - resize south by PIXELS
#   - wr - resize west  by PIXELS
#
# PIXELS can be a negative number.

# Window borders. Much cheaper to hardcode than query.
BORDER=2

# WM status bar height (top)
BAR_H=20

hc () {
    herbstclient "$@"
}

# Fetch window x, y, w, h
geom="$(hc get_attr clients.focus.floating_geometry)"
[ -z "$geom" ] && exit
wwh="${geom%%[+-]*}"
wxy="$(printf %s "$geom" | cut -b"$((${#wwh} + 1))"-)"
tw="${wwh%x*}"
th="${wwh#*x}"
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
        tx=$((sw - tw - BORDER))
        ;;
    s)
        ty=$((ty + ${2:-$AMOUNT}))
        ;;
    st)
        ty=$((sh - th - BORDER))
        ;;
    w)
        tx=$((tx - ${2:-$AMOUNT}))
        ;;
    wt)
        tx=$BORDER
        ;;
    c)
        tx=$(((sw - tw) / 2))
        ty=$(((sh - th) / 2))
        ;;
    nr)
        ty=$((ty - ${2:-$AMOUNT}))
        th=$((th + ${2:-$AMOUNT}))
        ;;
    er)
        tw=$((tw + ${2:-$AMOUNT}))
        ;;
    sr)
        th=$((th + ${2:-$AMOUNT}))
        ;;
    wr)
        tx=$((tx - ${2:-$AMOUNT}))
        tw=$((tw + ${2:-$AMOUNT}))
        ;;
    *)
        echo 'wm-throw: invalid direction (must be one of: north, east, south, west, center)' >&2
        exit 1
esac

new_geom="${tw}x${th}+${tx}+${ty}"
hc set_attr clients.focus.floating_geometry "$new_geom"
