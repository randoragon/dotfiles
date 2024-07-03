#!/bin/sh

mpcmap () {
    riverctl map -repeat normal "$1" "$2" spawn "mpc $3"
}

mpcmap None  XF86AudioPlay toggle
mpcmap None  XF86AudioStop stop
mpcmap None  XF86AudioPrev prev
mpcmap None  XF86AudioNext next
mpcmap Shift XF86AudioPrev 'seek -5'
mpcmap Shift XF86AudioNext 'seek +5'

mpcmap Super       P          toggle
mpcmap Super+Shift P          stop
mpcmap Super       semicolon  prev
mpcmap Super       apostrophe next
mpcmap Super+Shift semicolon  'seek -5'
mpcmap Super+Shift apostrophe 'seek +5'


pwmap () {
    riverctl map -repeat normal "$1" "$2" spawn \
        "pactl $3 @DEFAULT_SINK@ $4"
}

pwmap None  XF86AudioMute        set-sink-mute   toggle
pwmap Super BackSpace            set-sink-mute   toggle
pwmap None  XF86AudioRaiseVolume set-sink-volume +2%
pwmap Super equal                set-sink-volume +2%
pwmap None  XF86AudioLowerVolume set-sink-volume -2%
pwmap Super minus                set-sink-volume -2%
