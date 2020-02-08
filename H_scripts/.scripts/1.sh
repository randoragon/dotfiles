#!/bin/sh

# polybar dev window layout

i3-msg append_layout "$i3_LAYOUTS/polydown.json"
x-terminal-emulator --hold --class=polydown -d "$HOME/Projects/polydown" -e "vim -S" &
x-terminal-emulator --hold --class=manpage -d "$HOME/Projects/polydown" -e "./pdc -h | less" &
x-terminal-emulator --hold --class=server -d "$HOME/Projects/polydown" &
x-terminal-emulator --hold --class=client -d "$HOME/Projects/polydown" &
