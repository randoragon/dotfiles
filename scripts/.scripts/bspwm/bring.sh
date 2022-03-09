#!/bin/sh

lineno=0
tmp="$(mktemp)"
for wid in $(bspc query -N -n .window.!focused); do
    lineno=$((lineno + 1))
    desktop="$(bspc query -D -n "$wid" --names)"
    echo "$desktop" | grep -q '^_.*' && continue
    fullclass="$(xprop -id "$wid" | sed -n 's/^WM_CLASS(STRING) = //p')"
    class="$(echo "$fullclass" | cut -d\" -f4)"
    instance="$(echo "$fullclass" | cut -d\" -f2)"
    title="$(xdotool getwindowname "$wid")"

    printf '%-2s [%s] %s   %s "%s"\n' \
        $lineno "$desktop" "$wid" "$class:$instance" "$title"
done | dmenu -f -l 10 -p 'Bring:' | grep -o '0x[0-9A-F]\+' | while read -r wid; do
    bspc query -N -n "$wid".local || \
        bspc node "$wid" -d focused -g hidden=off
    echo "$wid" >"$tmp"
done

bspc node "$(cat -- "$tmp")" -f

rm -f -- "$tmp"
