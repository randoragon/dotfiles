#!/bin/sh

# This script is executed by xbindkeys when button1 is pressed on a wacom stylus device.

# I want the pen button to act as an eraser, but since it's not possible
# to make it act as a mouse right-click, I'm resorting to program-specific
# configuration which uses keyboard shortcuts specific to an application.
# The upside of this is that we can run completely different code in different
# situations, which grants pretty much limitless overloading potential.
# NOTE: many programs reject xdotool's sent input. Read xdotool's manpage for details.
window="$(xdotool getactivewindow)"
name="$(xdotool getactivewindow getwindowname)"
class="$(xprop -id "$window" | sed -n 's/^WM_CLASS[^"]*"//p' | sed 's/".*$//')"
if printf "%s" "$class" | grep -qi "aseprite"; then
    xdotool windowactivate --sync "$window" key x
    notify-send "$window" "$class"
fi
