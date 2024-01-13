#!/bin/sh

lineno=0
sel="$(for wid in $(bspc query -N -n .window.!focused); do
    lineno=$((lineno + 1))
    desktop="$(bspc query -D -n "$wid" --names)"
    echo "$desktop" | grep -q '^_.*' && continue
    fullclass="$(xprop -id "$wid" | sed -n 's/^WM_CLASS(STRING) = //p')"
    class="$(echo "$fullclass" | cut -d\" -f4)"
    instance="$(echo "$fullclass" | cut -d\" -f2)"
    title="$(xdotool getwindowname "$wid")"

    printf '%-2s [%s] %s   %s "%s"\n' \
        $lineno "$desktop" "$wid" "$class:$instance" "$title"
done | dmenu -f -l 10 -p 'Swap:'
)"

[ -z "$sel" ] && exit

wid="$(echo "$sel" | grep -o '0x[0-9A-F]\+')"
bspc node "$wid" -s focused -f
