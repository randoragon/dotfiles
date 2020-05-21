#!/bin/sh

# This script is executed by xbindkeys when button1 is pressed on a wacom tablet device.

if [ "$(xsetwacom get "$WACOM_STYLUS_ID" Mode)" = Absolute ]; then
    xsetwacom set "$WACOM_STYLUS_ID" Mode Relative
else
    xsetwacom set "$WACOM_STYLUS_ID" Mode Absolute
fi
