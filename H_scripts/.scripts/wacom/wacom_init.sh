#!/bin/sh

# Applies some default configurations that I like
# on my Wacom drawing tablet.

# Set device IDs (run `xsetwacom list devices` to see)
stylus=10
pad=11
eraser=19
cursor=20

# Set and export desired button IDs
WACOM_PAD_B1=11
WACOM_PAD_B2=12
WACOM_PAD_B3=13
WACOM_PAD_B4=14
WACOM_STYLUS_B1=15
WACOM_STYLUS_B2=16
export WACOM_PAD_B1 WACOM_PAD_B2 WACOM_PAD_B3 WACOM_PAD_B4 WACOM_STYLUS_B1 WACOM_STYLUS_B2

# Remap buttons
# (check your tablet's button IDs by running xev)
xsetwacom set "$pad" Button 1 "$WACOM_PAD_B1"
xsetwacom set "$pad" Button 2 "$WACOM_PAD_B2"
xsetwacom set "$pad" Button 3 "$WACOM_PAD_B3"
xsetwacom set "$pad" Button 8 "$WACOM_PAD_B4"
xsetwacom set "$stylus" Button 2 "$WACOM_STYLUS_B1"
xsetwacom set "$stylus" Button 3 "$WACOM_STYLUS_B2"

# Disable touch feature
xsetwacom set "$pad" Touch off
