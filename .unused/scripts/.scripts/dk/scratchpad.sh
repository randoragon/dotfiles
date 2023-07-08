#!/bin/sh

# Unlimited dwm-like scratchpads for dkwm.
# The script requires an "_sp" workspace for keeping scratchpads.
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
# and add a rule to dkwm that handles all scratchpads.
#
# Example:
#     scratchpad.sh sp_term toggle st -n sp

# Parse command-line arguments
[ $# -lt 2 ] && exit 1
name="$1"
action="$2"
shift 2

SPWS=_sp
SPDIR="${TMPDIR:-/tmp}/dkwm_sp.$USER"
# shellcheck disable=SC2174
mkdir -m 700 -p -- "$SPDIR" || exit 1

wid=
[ -r "$SPDIR/$name" ] && wid="$(cat -- "$SPDIR/$name")"

[ "$action" = toggle ] && {
    action=show
    [ -n "$wid" ] && {
        state="$(dkcmd status type=full num=1)"
        ws="$(echo "$state" | rg -o -r \$1 '^workspaces: .*\*([^:]+):')"
        echo "$state" | rg -q "^windows: .*$wid:$ws\b"
    } && action=hide
}

if [ "$action" = show ]; then
    if [ -n "$wid" ]; then
        ws=$(dkcmd status type=ws num=1 | rg -o -r \$1 '[AI]([^:]+)')
        dkcmd ws follow "$wid" "$ws"
        dkcmd win "$wid" focus
    elif [ $# -gt 0 ]; then
        # The first new node that appears will be considered the new scratchpad.
        # This technically could fail if another window was created by something
        # else simultaneously and got captured instead, but the odds of that are
        # incredibly slim and not worth overengineering this script.
        dkcmd status type=full num=2 | tac | rg -r \$1 '^active_window: (.*)' | head -n1 >"$SPDIR/$name" &
        "$@" &

        # If the scratchpad terminates, delete the cached window id file
        wait $!
        rm -f -- "$SPDIR/$name"
    fi
elif [ "$action" = hide ]; then
    dkcmd win 
    dkcmd ws send "$wid" "$SPWS"
else
    echo "scratchpad.sh: invalid action" >&2
fi
