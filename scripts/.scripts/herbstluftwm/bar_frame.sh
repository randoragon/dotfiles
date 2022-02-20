#!/bin/sh

# shellcheck disable=SC2059

hc () {
    herbstclient "$@"
}

# Color definitions
LAYOUT_FG='%{F#FF9F00}'

hc -i '(focus|layout)_changed|bar_frame' | while read -r _; do
    data="$(hc sprintf X '%s %s %s'                      \
            tags.focus.tiling.focused_frame.algorithm    \
            tags.focus.tiling.focused_frame.selection    \
            tags.focus.tiling.focused_frame.client_count \
            echo X)"
    algo="${data%% *}"
    widx="$(printf %s "$data" | cut -d' ' -f2)"
    wcnt="${data##* }"

    out="$LAYOUT_FG"

    # Print focused frame's layout, selection and no. clients
    case "$algo" in
        vertical)   txt="%{F-}%{T0} - "   fmt="%%{F-}%%{T0} %s/%s"   ;;
        horizontal) txt="|||%{F-}%{T0} - " fmt="|||%%{F-}%%{T0} %s/%s" ;;
        max)        txt="%{F-}%{T0} - "   fmt="%%{F-}%%{T0} %s/%s"   ;;
        grid)       txt="%{F-}%{T0} - "   fmt="%%{F-}%%{T0} %s/%s"   ;;
        *)          txt="?%{F-}%{T0} - "   fmt="?%%{F-}%%{T0} %s/%s"   ;;
    esac
    if [ "$wcnt" -gt 0 ]; then
        out="$out$(printf "$fmt\n" "$((widx + 1))" "$wcnt")"
    else
        out="$out$txt"
    fi

    printf "%s\n" "$out"
done
