#!/bin/sh

# This script is executed by xbindkeys when button1 is pressed on a wacom stylus device.

[ -z "$WACOM_RMB_FILE" ] && exit 1

if [ -f "$WACOM_RMB_FILE" ]; then
    xsetwacom set "$WACOM_STYLUS_ID" Button 1 1
    rm -- "$WACOM_RMB_FILE"
else
    xsetwacom set "$WACOM_STYLUS_ID" Button 1 3
    touch -- "$WACOM_RMB_FILE"
fi
