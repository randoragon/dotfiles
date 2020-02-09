#!/bin/sh

# polybar dev window layout

i3-msg append_layout "$i3_LAYOUTS/polydown.json"
x-terminal-emulator --class=polydown -d "$HOME/Projects/polydown" -e 'sh -c "vim -S; bash"' &
x-terminal-emulator --class=manpage -d "$HOME/Projects/polydown" -e 'sh -c "./pdc -h | less; bash"' &
x-terminal-emulator --class=server -d "$HOME/Projects/polydown" &
x-terminal-emulator --class=client -d "$HOME/Projects/polydown" &
