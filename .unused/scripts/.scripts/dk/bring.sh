#!/bin/sh

lineno=0
status="$(dkcmd status type=full num=1)"
workspaces="$(echo "$status" | rg ^workspaces:)"
ws_current="$(echo "$workspaces" | rg -o -r \$1 '^workspaces: .*\*[^:]+:([^:]+):')"
sel="$(for wininfo in $(echo "$status" | sed -n 's/^windows: //p' | rg -Pio '(?<!\*)0x[^ ]+'); do
    lineno=$((lineno + 1))
    wid="${wininfo%:*}"
    ws_id="${wininfo##*:}"
    ws="$(echo "$workspaces" | rg -o -r \$1 "^workspaces: .*$ws_id:([^ ]+):")"
    [ "$ws" = "$ws_current" ] && continue
    echo "$ws" | rg -q '^_.*' && continue
    fullclass="$(xprop -id "$wid" | sed -n 's/^WM_CLASS(STRING) = //p')"
    class="$(echo "$fullclass" | cut -d\" -f4)"
    instance="$(echo "$fullclass" | cut -d\" -f2)"
    title="$(xdotool getwindowname "$wid")"

    printf '%-2s [%s] %s   %s "%s"\n' \
        $lineno "$ws" "$wid" "$class:$instance" "$title"
done | dmenu -f -l 10 -p 'Bring:'
)"

[ -z "$sel" ] && exit

wid="$(echo "$sel" | rg -io '0x[0-9a-f]+')"
dkcmd ws follow "$wid" "$ws_current"
dkcmd win "$wid" focus
