#!/bin/sh

# This script is executed by the hotkey daemon when button1 is pressed on a wacom tablet device.

# Icon used for notifications
icon="/usr/share/icons/Adwaita/96x96/devices/input-tablet-symbolic.symbolic.png" 

# Read IDs stored in the init file
[ ! -f "$WACOM_INIT_FILE" ] && notify-send -u critical -i "$icon" "Wacom Intuos S" "Init file not found!" && exit 1
stylus="$(sed 1q "$WACOM_INIT_FILE")"

if [ "$(xsetwacom get "$stylus" Mode)" = Absolute ]; then
    xsetwacom set "$stylus" Mode Relative
    notify-send -u low -t 750 -i "$icon" "Wacom Intuos S" "<b>Relative</b> Mode"
else
    xsetwacom set "$stylus" Mode Absolute
    notify-send -u low -t 750 -i "$icon" "Wacom Intuos S" "<b>Absolute</b> Mode"
fi
