#!/bin/sh

logdir="${XDG_DATA_DIR:-$HOME/.local/share}/yambar"
logfile="$logdir/yambar.log"

mkdir -p -- "$logdir"

echo "[$(date +%a\ %Y-%m-%d\ %H:%M:%S\ %z)]" >>"$logfile"

yambar 2>>"$logfile" &
