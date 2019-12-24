#!/bin/bash

# This script produces a rofi GUI menu for selecting
# a playlist to which add the current playing song
# from MPD.

# Source: https://github.com/davatorium/rofi/wiki/Script-Launcher

WORKINGDIR="$HOME/.config/rofi/"
MAP="$WORKINGDIR/playlists.csv"

cat "$MAP" \
    | cut -d ',' -f 1 \
    | rofi -dmenu -p "Add to playlist" -i -matching normal \
    | head -n 1 \
    | xargs -i --no-run-if-empty grep "{}" "$MAP" \
    | cut -d ',' -f 2 \
    | head -n 1 \
    | xargs -i --no-run-if-empty /bin/bash -c "{}"

exit 0
