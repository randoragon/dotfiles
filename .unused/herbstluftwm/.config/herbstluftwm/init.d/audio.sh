#!/bin/sh

MOD="${MOD:-Super}"

mpcmap () {
    keys="$1"
    shift
    herbstclient keybind "$keys" spawn mpc "$@"
}

mpcmap XF86AudioPlay       toggle
mpcmap XF86AudioStop       stop
mpcmap XF86AudioPrev       prev
mpcmap XF86AudioNext       next
mpcmap Shift+XF86AudioPrev seek -5
mpcmap Shift+XF86AudioNext seek +5

mpcmap "$MOD"+p                toggle
mpcmap "$MOD"+Shift+p          stop
mpcmap "$MOD"+semicolon        prev
mpcmap "$MOD"+apostrophe       next
mpcmap "$MOD"+Shift+semicolon  seek -5
mpcmap "$MOD"+Shift+apostrophe seek +5

pwmap () {
    herbstclient keybind "$1" spawn pactl "$2" @DEFAULT_SINK@ "$3"
}

pwmap XF86AudioMute        set-sink-mute   toggle
pwmap "$MOD"+BackSpace     set-sink-mute   toggle
pwmap XF86AudioRaiseVolume set-sink-volume +2%
pwmap "$MOD"+equal         set-sink-volume +2%
pwmap XF86AudioLowerVolume set-sink-volume -2%
pwmap "$MOD"+minus         set-sink-volume -2%
