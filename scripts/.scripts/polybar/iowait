#!/bin/sh

# Requires iostat command from sysstat package.

print () {
    echo " ${4%.*}%"
}

iostat -c 5 | while read -r line; do
    [ -z "$line" ] && continue
    # shellcheck disable=SC2086
    echo "$line" | grep -q '^[0-9]' && print $line
done
