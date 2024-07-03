#!/bin/sh

wacombind () {
    riverctl map normal None  "$1" spawn "~/.scripts/wacom/wacom_$2.sh"
    riverctl map normal Super "$1" spawn "~/.scripts/wacom/wacom_$2.sh"
}

wacombind button11 pad_b1
wacombind button12 pad_b2
wacombind button13 pad_b3
wacombind button14 pad_b4
wacombind button15 stylus_b1
wacombind button16 stylus_b2
