#!/bin/sh

swww-daemon --no-cache &

riverctl map normal Super+Control+Shift Slash spawn 'swww clear 111111'
riverctl map normal Super+Control Slash spawn '~/.scripts/wallpaper_random.sh'