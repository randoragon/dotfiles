#!/bin/sh

# This script is executed by xbindkeys when button1 is pressed on a wacom tablet device.

if [ "$(xsetwacom get "$WACOM_STYLUS_ID" Mode)" = Absolute ]; then
    xsetwacom set "$WACOM_STYLUS_ID" Mode Relative
    notify-send -u low -t 750 -i "/usr/share/icons/Adwaita/96x96/devices/input-tablet-symbolic.symbolic.png" "Wacom Intuos S" "<b>Relative</b> Mode"
else
    xsetwacom set "$WACOM_STYLUS_ID" Mode Absolute
    notify-send -u low -t 750 -i "/usr/share/icons/Adwaita/96x96/devices/input-tablet-symbolic.symbolic.png" "Wacom Intuos S" "<b>Absolute</b> Mode"
fi
