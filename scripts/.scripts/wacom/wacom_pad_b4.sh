#!/bin/sh

# This script is executed by the hotkey daemon when button4 is pressed on a wacom tablet device.

# Icon used for notifications
icon="/usr/share/icons/Adwaita/96x96/devices/input-tablet-symbolic.symbolic.png" 
NOTIF_ID=9251264

if ! xkeycheck lsuper; then
    xdotool keyup super
    xdotool keydown super
    dunstify -i "$icon" -r "$NOTIF_ID" -u low -t 0 "Wacom Intuos S" "Super Mode <b>ON</b>"
else
    xdotool keyup super
    dunstify -C "$NOTIF_ID"
fi
