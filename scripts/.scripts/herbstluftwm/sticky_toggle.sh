#!/bin/sh

# Sticky windows for herbstluftwm. Implementation should be safe
# (based on unique PIDs), although there is some flicker when
# switching tags and the shift in focus is not always intuitive.
# Intended for floating windows only. It "works" for tiled, but
# the layout of your windows will get regularly messed up.
#
# Usage:
#     sticky_toggle.sh
#
# The script acts on the focused window.

hc () {
    herbstclient "$@"
}

hc lock
info="$(hc sprintf X '%s %s' clients.focus.winid clients.focus.pid echo X)"
wid="${info% *}"
pid="${info#* }"
[ "$pid" = -1 ] && echo 'window has unset pid (-1)' >&2 && exit 1
[ -n "$pid" ] && {
    lpid="$(hc get_attr my_stickypid_"$pid")"
    if [ -n "$lpid" ]; then
        kill "$lpid"
        hc remove_attr my_stickypid_"$pid"
    else
        # Spawn a background listener who will make sure
        # the window stays in the focused tag and will
        # self-cleanup if the window gets closed.
        hc -i '(tag|attribute)_changed' | while read -r line; do
            if [ "$(printf %s "$line" | cut -f2)" = clients."$wid".pid ]; then
                hc remove_attr my_stickypid_"$pid"
                break
            else
                hc or . substitute PREV clients.focus.winid \
                            chain , bring "$wid"            \
                                  , jumpto PREV             \
                                  , true                    \
                      . bring "$wid"
            fi
        done &
        lpid=$!
        hc new_attr uint my_stickypid_"$pid" $lpid
        hc watch clients."$wid".pid
    fi
}
hc unlock
