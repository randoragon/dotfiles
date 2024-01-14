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
"Usage:\n\
\tscratchpad [-h,--help,-n] NAME show|hide|toggle [CMD...]\n\
\n\
NAME - a WM_CLASS instance name (should probably be unique).\n\
CMD  - an optional command that spawns a scratchpad if it does not\n\
       exist when needing to be shown.
\n\
show   - shows a given scratchpad, runs CMD if non-existent\n\
hide   - hides a given scratchpad, if it exists\n\
toggle - toggles between shown and hidden states (default)\n\
\n\
By default, it is assumed that CMD will spawn a window in such a\n\
way that the WM_CLASS instance name is set to NAME (various programs\n\
like terminal emulators often support this with command-line args).\n\
However, if for whatever reason that is not the case, you can pass\n\
the \"-n\" option to force scratchpad to attempt to set this property\n\
automatically. For this to be possible, CMD must leave the window's\n\
pid in the \$! variable for scratchpad to read, so pass it carefully.\n\
\n\
If you wish for the scratchpads to float, be sticky or whatever else,\n\
you have to use some NAME convention and ask your WM to set the right\n\
attributes with pattern matching rules (common feature in tiling WMs).\n" >&2
}

# Print usage
[ "$1" = '-h' ] || [ "$1" = '--help' ] && usage && exit
[ $# -lt 2 ] && usage && exit 1

name="$1"
action="$2"
cmd=
[ $# -gt 2 ] && {
    shift 2
    cmd="$*"
}
wid=
[ -r "$SPDIR/$name" ] && wid="$(cat -- "$SPDIR/$name")"
cur_desktop=$(($(wmctrl -d | grep -F -m1 \* | cut -d' ' -f1)))

show () {
    if [ -n "$wid" ]; then
        xdotool set_desktop_for_window "$wid" $cur_desktop windowactivate "$wid"
    elif [ -n "$cmd" ]; then
        $cmd &
        pid=$!

        # Cache the window ID of the new scratchpad
        xdo id -mn "$name" >"$SPDIR/$name"

        # If the scratchpad terminates, delete the cached window id file
        wait $pid
        rm -f -- "$SPDIR/$name"
    fi
}

hide () {
    win_desktop="$(xprop -notype -id "$wid" _NET_WM_DESKTOP)"
    win_desktop="${win_desktop##*= }"
    if [ $((win_desktop)) -ne $cur_desktop ] || xprop -notype -id "$wid" _NET_WM_STATE | grep -qF -m1 STATE_HIDDEN; then
        false
    else
        wmctrl -i -r "$wid" -b add,hidden
    fi
}

case "$action" in
    toggle) hide || show ;;
    show) show ;;
    hide) hide ;;
    *) usage ; exit 1 ;;
esac
