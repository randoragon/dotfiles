#!/bin/sh

# This script copies every* hist.$host.m3u file from Sync directory to the
# Music directory. It's intended to be run periodically (e.g. cronjob).
#
# (*) The opposite is done for the running host's history file -- it is
#     copied from Music to Sync.

PLMUSICDIR=~/Music/Playlists
PLSYNCDIR=~/Sync/Music/Playlists

[ ! -d "$PLMUSICDIR" ] && exit
[ ! -d "$PLSYNCDIR" ] && exit

host="$(cat /etc/hostname)"
myhist="hist.$host.m3u"

find "$PLSYNCDIR" -maxdepth 1 -type f -name 'hist.*.m3u' \! -name "$myhist" \
    -exec cp -- '{}' "$PLMUSICDIR/" \;

[ -f "$PLMUSICDIR/$myhist" ] && cp -- "$PLMUSICDIR/$myhist" "$PLSYNCDIR/"
