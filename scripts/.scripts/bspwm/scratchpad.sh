#!/bin/sh

# Unlimited dwm-like scratchpads for bspwm.
#
# Usage:
#     scratchpad.sh NAME show|hide|toggle [CMD...]
#
# NAME - a unique name identifier (must be a valid filename).
# CMD  - an optional command that spawns a scratchpad if it does not
#        exist when needing to be shown.
#
# show   - shows a given scratchpad, runs CMD if non-existent
# hide   - hides a given scratchpad, if it exists
# toggle - toggles between shown and hidden states (default)
#
# If you want your scratchpads to float/be sticky, make sure CMD
# creates windows with instance/class set to some conventional string
# and add a rule to bspwm that handles all scratchpads.
#
# Example:
#     scratchpad.sh sp_term toggle st -n sp

# Parse command-line arguments
[ $# -lt 2 ] && exit 1
name="$1"
action="$2"
shift 2

SPDIR="${TMPDIR:-/tmp}/bspwm_sp"
# shellcheck disable=SC2174
mkdir -m 700 -p -- "$SPDIR" || exit 1

wid=
[ -r "$SPDIR/$name" ] && wid="$(cat -- "$SPDIR/$name")"

[ "$action" = toggle ] && {
    action=show
    [ -n "$wid" ] && bspc query -N -n "$wid".\!hidden.local && \
        action=hide
}

if [ "$action" = show ]; then
    # shellcheck disable=SC2015
    # This is NOT an if-else block, it's supposed to be like this
    [ -n "$wid" ] && {
        bspc node "$wid" -m focused
        bspc node "$wid" -g hidden=off -f
    } || {
        [ $# -gt 0 ] && {
            # The first new node that appears will be considered the new scratchpad.
            # This technically could fail if another window was created by something
            # else simultaneously and got captured instead, but the odds of that are
            # incredibly slim and not worth overengineering this script.
            bspc subscribe node_add -c 1 | cut -d' ' -f5 >"$SPDIR/$name" &
            "$@" &

            # If the scratchpad terminates, delete the cached window id file
            wait $!
            rm -f -- "$SPDIR/$name"
        }
    }
elif [ "$action" = hide ]; then
    bspc node "$wid" -g hidden=on
else
    echo "scratchpad.sh: invalid action" >&2
fi
