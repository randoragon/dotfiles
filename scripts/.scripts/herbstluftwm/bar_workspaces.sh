#!/bin/sh

# shellcheck disable=SC2059

hc () {
    herbstclient "$@"
}

# Color definitions
DEFAULT_FG='%{F#FFF}'
DEFAULT_BG='%{B#000}'
MON_FG='%{F#F0F}'
MON_BG='%{B#000}'
TAG_ACTIVE_FG='%{F#000}'
TAG_ACTIVE_BG='%{B#88FF00}'
TAG_URGENT_FG='%{F#FF0000}'
TAG_URGENT_BG='%{B#000}'

# Spawn listener to notify the status bar of focus changes
hc -i 'tag_(changed|flags|added|removed|renamed)|statusbar_init' | \
    while read -r _; do

    moni="$(hc get_attr monitors.focus.index)"
    out="$MON_FG$MON_BG $moni  "
    for i in $(hc tag_status); do
        case "$i" in
            .*) continue ;;
           \#*) fgc="$TAG_ACTIVE_FG"
                bgc="$TAG_ACTIVE_BG"
                ;;
            !*) fgc="$TAG_URGENT_FG"
                bgc="$TAG_URGENT_BG"
                ;;
             *) fgc="$DEFAULT_FG"
                bgc="$DEFAULT_BG"
                ;;
        esac
        tag="${i#?}"
        out="$out$fgc$bgc%{A1:herbstclient use $tag:} $tag %{A}"
    done

    printf "%s\n" "$out$DEFAULT_FG$DEFAULT_BG"
done
