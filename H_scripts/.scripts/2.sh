#!/bin/sh

# Setup for importing into beets

i3-msg append_layout "$i3_LAYOUTS/beetsimport.json"
x-terminal-emulator -c dualf -t dualf -e dualf ~/Music ~/Downloads/Music &
x-terminal-emulator -c "beetsterm" -e zsh -c "cd ~/Downloads/Music; zsh"
