#!/bin/sh

# Jump to any window. EWMH-compliant.

sel="$(wmctrl -lx | nl -w2 -s' ' | dmenu -f -l 10 -p 'Jump To:')"
[ -z "$sel" ] && exit

wid="0x${sel#*x}"
wid="${wid%% *}"
wmctrl -i -a "$wid"
