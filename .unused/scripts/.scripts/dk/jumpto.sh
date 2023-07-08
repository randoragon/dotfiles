#!/bin/sh

lineno=0
status="$(dkcmd status type=full num=1)"
workspaces="$(echo "$status" | rg ^workspaces:)"
sel="$(for wininfo in $(echo "$status" | sed -n 's/^windows: //p' | rg -Po '(?<!\*)0x[^ ]+'); do
    lineno=$((lineno + 1))
    wid="${wininfo%:*}"
    ws_id="${wininfo##*:}"
    ws="$(echo "$workspaces" | rg -o -r \$1 "^workspaces: .*$ws_id:([^ ]+):")"
    echo "$ws" | rg -q '^_.*' && continue
    fullclass="$(xprop -id "$wid" | sed -n 's/^WM_CLASS(STRING) = //p')"
    class="$(echo "$fullclass" | cut -d\" -f4)"
    instance="$(echo "$fullclass" | cut -d\" -f2)"
    title="$(xdotool getwindowname "$wid")"

    printf '%-2s [%s] %s   %s "%s"\n' \
        $lineno "$ws" "$wid" "$class:$instance" "$title"
done | dmenu -f -l 10 -p 'Jump To:'
)"

[ -z "$sel" ] && exit

wid="$(echo "$sel" | rg -io '0x[0-9a-f]+')"
xdotool windowactivate "$wid"
