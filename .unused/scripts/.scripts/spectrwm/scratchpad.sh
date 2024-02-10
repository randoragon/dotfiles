#!/bin/sh

# WM/DE-agnostic, universal way of managing "scratchpad" applications.
# Requires some form of compliance with EWMH standards.
# I wrote this script for SpectrWM. It works well and fast enough for me.
#
# Dependencies:
# - xprop
# - xdo
# - xdotool
# - wmctrl

SPDIR="${TMPDIR:-/tmp}/spectrwm_sp.$USER"
# shellcheck disable=SC2174
mkdir -m 700 -p -- "$SPDIR" || exit 1

usage () {
    printf \
'Usage:\n\
\tscratchpad [-h,--help,-n] NAME [CMD...]\n\
\n\
NAME - a WM_CLASS instance name (should probably be unique).\n\
CMD  - an optional command that spawns a scratchpad if it does not\n\
       exist when needing to be shown.\n' >&2
}

# Print usage
[ "$1" = '-h' ] || [ "$1" = '--help' ] && usage && exit
[ $# -lt 2 ] && usage && exit 1

name="$1"
cmd=
[ $# -gt 1 ] && {
    shift
    cmd="$*"
}

spawn () {
    $cmd &
    pid=$!

    # Cache the window ID of the new scratchpad
    xdo id -mn "$name" >"$SPDIR/$name"

    # If the scratchpad terminates, delete the cached window id file
    wait $pid
    rm -f -- "$SPDIR/$name"
}

toggle () {
    if xwininfo -id "$wid" | grep -Fq -m1 'Map State: IsViewable'; then
        wmctrl -i -r "$wid" -b add,hidden
        # By convention, keep all hidden scratchpads on the last workspace,
        # to keep them from "falsely" occupying random iconified lists.
        wmctrl -i -r "$wid" -t 8
    else
        cur_desktop=$(($(wmctrl -d | grep -F -m1 \* | cut -d' ' -f1)))
        wmctrl -i -r "$wid" -t $cur_desktop
        # For some reason with just one activation, there's a bug:
        # If a scratchpad is activated on an empty workspace, it's
        # out of focus. To prevent this, activate twice.
        xdo activate -d "$wid"
        xdo activate -d "$wid"
    fi
}

wid=
[ -r "$SPDIR/$name" ] && wid="$(cat -- "$SPDIR/$name")"
if [ -n "$wid" ]; then
    toggle
else
    spawn
fi
