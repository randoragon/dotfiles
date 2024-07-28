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
        "amixer sset Master $3"
}

pwmap None  XF86AudioMute        toggle
pwmap Super BackSpace            toggle
pwmap None  XF86AudioRaiseVolume 1%+
pwmap Super equal                1%+
pwmap None  XF86AudioLowerVolume 1%-
pwmap Super minus                1%-

riverctl map normal Super+Control P spawn "~/.scripts/choose_default_sink.sh"
