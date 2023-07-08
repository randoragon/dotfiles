#!/bin/sh

# Hides or shows the status bar.

pidof -q polybar || {
    bspc config top_padding 20
    ~/.scripts/polybar/launch &
    exit
}

if [ "$(bspc config top_padding)" = 0 ]; then
    polybar-msg cmd show
    bspc config top_padding 20
else
    polybar-msg cmd hide
    bspc config top_padding 0
fi
