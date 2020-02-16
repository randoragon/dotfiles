#!/bin/sh

# Setup for importing into beets

i3-msg append_layout "$i3_LAYOUTS/beetsimport.json"
doublecmd -L ~/Music -R ~/Downloads/Music &
x-terminal-emulator &
