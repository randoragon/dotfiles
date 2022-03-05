#!/bin/sh

# Opens a menu of all minimized windows and "unminimizes"
# the chosen one. Counterpart to the minimize.sh script.
#
# Usage:
#       unminimize.sh

# File format (tab-separated):
# tag    time    winid    class:instance    title...
FILE="${TMPDIR:-/tmp}/bspwm.$(whoami).minimized"
[ ! -r "$FILE" ] || [ "$(wc -l <"$FILE")" = 0 ] && {
    polybar-msg hook bspwm_minimized 1
    exit
}

# What to do if some window inside FILE does not exist anymore?
# We want to remove it from FILE automatically. To do this, a
# temporary file is created, which we'll write only valid lines
# into. At the end, tmp will be moved into FILE, replacing it.
tmp="$(mktemp)"

lineno=0
sel="$(
while read -r line; do
    wid="$(printf %s "$line" | cut -f3)"
    bspc query -N -n "$wid" >/dev/null && {
        lineno=$((lineno + 1))
        tag="$(printf %s "$line"   | cut -f1)"
        time="$(printf %s "$line"  | cut -f2)"
        class="$(printf %s "$line" | cut -f4)"
        title="$(printf %s "$line" | cut -f5-)"
        printf '%s\n' "$line" >>"$tmp"
        printf '%-2s [%s] %s %s   %s "%s"\n' \
            $lineno "$tag" "$time" "$wid" "$class" "$title"
    }
done <"$FILE" | dmenu -f -l 10 -p 'Unminimize:'
)"

[ -n "$sel" ] && {
    # Recover window id from sel
    lineno="${sel%% *}"
    wid="$(sed -n "${lineno}p" "$tmp" | cut -f3)"

    # Focus the selected window and remove it from the list
    [ -n "$wid" ] && bspc node "$wid" -d focused:focused -f
    sed -i "${lineno}d" "$tmp"
}

mv -- "$tmp" "$FILE"

polybar-msg hook bspwm_minimized 1
