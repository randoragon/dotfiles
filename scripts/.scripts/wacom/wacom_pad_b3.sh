#!/bin/sh

# This script is executed by the hotkey daemon when button3 is pressed on a wacom tablet device.

if [ -z "$(pidof florence)" ]; then
    setsid florence
else
    killall florence
fi

