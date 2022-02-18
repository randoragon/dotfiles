#!/bin/sh

# Force-removes a frame, closing all of its windows.
# If a floating window is focused, or the focused frame
# is the last one in the current tag, nothing happens.

hc () {
    herbstclient "$@"
}

# Ignore if a floating is focused
floating="$(hc attr clients.focus.floating)"
[ "$floating" = true ] && exit

# Ignore if this is the only frame
frame_count="$(hc attr tags.focus.frame_count)"
[ "$frame_count" -lt 2 ] && exit

hc lock_tag
while [ "$(hc attr tags.focus.tiling.focused_frame.client_count)" -gt 1 ]; do
    hc close
done
hc close_and_remove
hc unlock_tag
