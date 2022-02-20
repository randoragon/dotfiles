#!/bin/sh

# Kills or spawns the status bar.
# Spawned status bars are automatically lowered.

hc () {
    herbstclient "$@"
}

if pidof -q polybar; then
    pkill -x polybar
    hc set_attr monitors.focus.pad_up 0
else
    hc set_attr monitors.focus.pad_up 20
    ~/.config/polybar/launch.sh
    wid="$(xdo id -mn polybar)"
    [ -n "$wid" ] && hc lower "$wid"

    # Send dummy hooks to force bar_workspaces.sh and
    # bar_frame.sh to print an initial state for polybar.
    hc chain , emit_hook bar_workspaces \
             , emit_hook bar_frame
fi
