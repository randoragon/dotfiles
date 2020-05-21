# This file is sourced in xinitrc to apply
# some default configuration to a wacom device
# and also export some variables to allow outside
# scripts to be more flexible.

# Extract and export device IDs (run `xsetwacom list devices` to see)
devices="$(xsetwacom list devices)"
WACOM_STYLUS_ID="$(printf "%s" "$devices" | grep "type: STYLUS" | sed 's/^.*id: //;s/\s*type: .*//')"
WACOM_PAD_ID="$(printf "%s" "$devices" | grep "type: PAD" | sed 's/^.*id: //;s/\s*type: .*//')"
WACOM_ERASER_ID="$(printf "%s" "$devices" | grep "type: ERASER" | sed 's/^.*id: //;s/\s*type: .*//')"
WACOM_CURSOR_ID="$(printf "%s" "$devices" | grep "type: CURSOR" | sed 's/^.*id: //;s/\s*type: .*//')"
export WACOM_STYLUS_ID WACOM_PAD_ID WACOM_ERASER_ID WACOM_CURSOR_ID

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
xsetwacom set "$WACOM_PAD_ID" Button 8 "$WACOM_PAD_B1"
xsetwacom set "$WACOM_PAD_ID" Button 3 "$WACOM_PAD_B2"
xsetwacom set "$WACOM_PAD_ID" Button 2 "$WACOM_PAD_B3"
xsetwacom set "$WACOM_PAD_ID" Button 1 "$WACOM_PAD_B4"
xsetwacom set "$WACOM_STYLUS_ID" Button 2 "$WACOM_STYLUS_B1"
xsetwacom set "$WACOM_STYLUS_ID" Button 3 "$WACOM_STYLUS_B2"

# Disable touch feature
xsetwacom set "$WACOM_PAD_ID" Touch off

# Set absolute mode
xsetwacom set "$WACOM_STYLUS_ID" Mode Absolute

# Set minimum pen proximity (subjective preference)
xsetwacom set "$WACOM_STYLUS_ID" CursorProximity 45

# Rotate upside-down (works better with my setup)
xsetwacom set "$WACOM_STYLUS_ID" Rotate half
