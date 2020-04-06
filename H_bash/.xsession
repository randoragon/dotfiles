#!/bin/sh

xidlehook --not-when-audio --timer 600 'physlock' '' &
export MPD_HOST="$HOME/.mpd/socket"
export i3_LAYOUTS="$HOME/.config/i3/layouts"

