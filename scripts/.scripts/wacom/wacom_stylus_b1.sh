#!/bin/sh

# This script is executed by the hotkey daemon when button1 is pressed on a wacom stylus device.

# Icon used for notifications
icon="/usr/share/icons/Adwaita/96x96/devices/input-tablet-symbolic.symbolic.png" 

# Read IDs stored in the init file
[ ! -f "$WACOM_INIT_FILE" ] && notify-send -u critical -i "$icon" "Wacom Intuos S" "Init file not found!" && exit 1
stylus="$(sed 1q "$WACOM_INIT_FILE")"

[ -z "$WACOM_RMB_FILE" ] && notify-send -u critical -i "$icon" "Wacom Intuos S" "WACOM_RMB_FILE variable\nis not set!" && exit 1

if [ -f "$WACOM_RMB_FILE" ]; then
    xsetwacom set "$stylus" Button 1 1
    notify-send -u low -t 750 -i "$icon" "Wacom Intuos S" "<b>Left-Click</b> Mode"
    rm -- "$WACOM_RMB_FILE"
else
    xsetwacom set "$stylus" Button 1 3
    notify-send -u low -t 750 -i "$icon" "Wacom Intuos S" "<b>Right-Click</b> Mode"
    touch -- "$WACOM_RMB_FILE"
fi
