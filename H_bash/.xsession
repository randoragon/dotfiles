#!/bin/sh

alias i3lock="i3lock -e -f -m -i ~/Pictures/background_lock.png -k --indicator --keylayout 0 --radius=160 --timecolor=7de317bb --datecolor=7de31788 --layoutcolor=7de31766 --wrongcolor=ffffffff --datestr='%A, %d %b %Y'"
xidlehook --not-when-audio --timer 600 'i3lock -e -f -m -i ~/Pictures/background_lock.png -k --indicator --keylayout 0 --radius=160 --timecolor=7de317bb --datecolor=7de31788 --layoutcolor=7de31766 --wrongcolor=ffffffff --datestr="%A, %d %b %Y"' '' &
export MPD_HOST="$HOME/.mpd/socket"
export i3_LAYOUTS="$HOME/.config/i3/layouts"

