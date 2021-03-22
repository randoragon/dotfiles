#!/usr/bin/sh

# This script is run every time ncmpcpp registers a song change.

printf "%s" "$(mpc current --format '%artist% - %title%')    " >~/.cache/obs-now-playing.txt
