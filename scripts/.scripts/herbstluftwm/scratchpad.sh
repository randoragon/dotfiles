#!/bin/sh

# Unlimited dwm-like scratchpads for HerbstluftWM.
#
# Usage:
#     scratchpad.sh NAME show|hide|toggle|remap [CMD...]
#
# NAME - a WM_CLASS instance name (must be unique).
# CMD  - an optional command that spawns a scratchpad if it does not
#        exist when needing to be shown. The command MUST guarantee
#        that the program has WM_CLASS instance property set to NAME.
#
# show   - shows a given scratchpad, runs CMD if non-existent
# hide   - hides a given scratchpad, if it exists
# toggle - toggles between shown and hidden states (default)
# remap  - toggle scratchpad status for the focused window.
#          if used on an existing scratchpad, it will "forget"
#          that scratchpad and act as if it never existed.
#          if used on any other window, it will consider that
#          window to be a new scratchpad (any previous scratchpad
#          will be unhidden and forgotten).
#
# Example:
#     scratchpad.sh sp_term toggle st -n sp_term

# Parse command-line arguments
[ $# -lt 2 ] && exit 1
name="$1"
action="$2"
shift 2

HOOK_PREFIX=spwid_
ATTR_PREFIX=my_spwid_ # must begin with "my_" (herbstluftwm(1))

hc () {
    herbstclient "$@"
}

spawn_listener () {
    # Window IDs are not unique, but PIDs are. If the PID of the window
    # ever changes, that means the process got killed or replaced by
    # something we no longer care about.
    # Additionally, if the scratchpad gets remapped (which is detected
    # by a change in $ATTR_PREFIX$name), gracefully terminate.
    hc -w attribute_changed "clients.$1.pid|$ATTR_PREFIX$name" | while read -r line; do
        [ "$(printf %s "$line" | cut -f2)" = "$ATTR_PREFIX$name" ] && \
            break
        hc remove_attr "$ATTR_PREFIX$name"
    done &
    hc chain , watch clients."$1".pid \
             , watch "$ATTR_PREFIX$name"
}

wid="$(hc get_attr "$ATTR_PREFIX$name")"
[ "$action" = toggle ] && {
    action=show
    [ -n "$wid" ] && hc compare clients."$wid".visible = 1 && \
        action=hide
}

create=
if [ "$action" = show ]; then
    # shellcheck disable=SC2015
    # (this is not an if-else block, it's meant to be like this)
    [ -n "$wid" ] && hc bring "$wid" || {
        [ $# -gt 0 ] && create=1
    }
elif [ "$action" = hide ]; then
    hc set_attr clients."$wid".minimized true
elif [ "$action" = remap ]; then
    focus="$(hc get_attr clients.focus.winid)"
    [ -z "$focus" ] && exit
    if [ -n "$wid" ]; then
        if [ "$wid" = "$focus" ]; then
            hc remove_attr "$ATTR_PREFIX$name"
        else
            hc chain , lock                                    \
                     , set_attr "$ATTR_PREFIX$name" "$focus"   \
                     , set_attr clients."$wid".minimized false \
                     , jumpto "$focus"                         \
                     , unlock
            spawn_listener "$focus"
        fi
    else
        hc new_attr string "$ATTR_PREFIX$name" "$focus"
        spawn_listener "$focus"
    fi
else
    echo "scratchpad.sh: invalid action" >&2
fi

[ -n "$create" ] && {
    # Listen to store the about-to-be-spawned window's id
    hc -w rule "$HOOK_PREFIX$name" | while read -r line; do
        newwid="$(printf %s "$line" | cut -f3)"
        hc new_attr string "$ATTR_PREFIX$name" "$newwid"
        spawn_listener "$newwid"
    done &

    hc rule once instance="$name" hook="$HOOK_PREFIX$name"

    "$@" &
}
