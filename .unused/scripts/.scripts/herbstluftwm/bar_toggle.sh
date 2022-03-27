#!/bin/sh

# Hides or shows polybar.

hc () {
    herbstclient "$@"
}

pidof -q polybar || {
    hc set_attr monitors.focus.pad_up 20
    ~/.scripts/polybar/launch &
    wid="$(xdo id -mn polybar)"
    [ -n "$wid" ] && hc lower "$wid"

    # Send dummy hooks to force bar_workspaces.sh and
    # bar_frame.sh to print an initial state for polybar.
    hc chain , emit_hook bar_workspaces \
             , emit_hook bar_frame
    exit
}

if hc compare monitors.focus.pad_up = 0; then
    polybar-msg cmd show
    hc set_attr monitors.focus.pad_up 20
else
    polybar-msg cmd hide
    hc set_attr monitors.focus.pad_up 0
fi
