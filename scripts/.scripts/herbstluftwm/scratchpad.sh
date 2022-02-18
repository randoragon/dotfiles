#!/bin/sh

# Unlimited scratchpads for HerbstluftWM.

usage () {
    printf \
"Usage:\n\
\tscratchpad.sh [-h,--help] NAME show|hide|toggle [CMD...]\n\
\n\
NAME - a WM_CLASS instance name (must be unique).\n\
CMD  - an optional command that spawns a scratchpad if it does not\n\
       exist when needing to be shown. The command MUST guarantee
       that the program has WM_CLASS instance property set to NAME.\n\
\n\
show   - shows a given scratchpad, runs CMD if non-existent\n\
hide   - hides a given scratchpad, if it exists\n\
toggle - toggles between shown and hidden states (default)\n
\n\
Example:\n\
\tscratchpad.sh sp_term toggle st -n sp_term\n" >&2
}

# Print usage
[ "$1" = '-h' ] || [ "$1" = '--help' ] && usage && exit
[ $# -lt 2 ] && usage && exit 1

# Parse command-line arguments
name="$1"
action="$2"
cmd=
[ $# -gt 2 ] && {
    shift 2
    cmd="$*"
}

HOOK_PREFIX=spwid_
ATTR_PREFIX=my_spwid_ # must begin with my_ (herbstluftwm(1))
hc () {
    herbstclient "$@"
}

show () {
    wid="$(hc get_attr "$ATTR_PREFIX$name")"
    [ -n "$wid" ] && hc bring "$wid" || {
        hc remove_attr "$ATTR_PREFIX$name"
        [ -n "$cmd" ] && {
            echo eo
            hc new_attr string "$ATTR_PREFIX$name" \
                "$(hc -w rule "$HOOK_PREFIX$name" | cut -f3)" &
            hc rule once instance="$name" hook="$HOOK_PREFIX$name"
            $cmd &
        }
    }
}

hide () {
    wid="$(hc get_attr "$ATTR_PREFIX$name")"
    [ -z "$wid" ] && return 1
    hc compare clients."$wid".visible = 0 && return 1
    hc silent attr clients."$wid".minimized true
}

case "$action" in
    toggle) hide || show ;;
    show) show ;;
    hide) hide ;;
    *) usage ; exit 1 ;;
esac

# xdotool search --onlyvisible --classname "$name" windowunmap \
#     || xdotool search --classname "$name" windowmap \
#     || $cmd
