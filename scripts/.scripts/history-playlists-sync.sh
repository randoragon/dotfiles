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

# Export own history to Sync first
[ -f "$PLMUSICDIR/$myhist" ] && cp -- "$PLMUSICDIR/$myhist" "$PLSYNCDIR/"

# Sleep for a minute -- if there are Sync devices present in the network,
# they will have posted their histories at the same time, so before pulling
# it's a good idea to wait for the synchronization to happen.
sleep 60

# Import other devices' histories from Sync
# Preprocess: my phone app export m3u with some metadata and absolute paths - clean it up
sed -i -e '/^#/d' -e "s|^Sync/Music/||" "$PLSYNCDIR/hist.phone.m3u"

find "$PLSYNCDIR" -maxdepth 1 -type f -name 'hist.*.m3u' \! -name "$myhist" \
    -exec cp -- '{}' "$PLMUSICDIR/" \;
