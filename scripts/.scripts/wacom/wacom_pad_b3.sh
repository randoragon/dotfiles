#!/bin/sh

# This script is executed by xbindkeys when button3 is pressed on a wacom tablet device.

if [ -z "$(pidof florence)" ]; then
    setsid florence
else
    killall florence
fi

