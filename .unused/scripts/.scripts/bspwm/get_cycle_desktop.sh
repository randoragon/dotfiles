#!/bin/sh

# Returns a selector to the next/prev desktop which is
# local, occupied and does not begin with "_".
#
# Usage:
#       get_cycle_desktop.sh DIR
# DIR must be either "next" or "prev"

path="focused#$1.local.occupied"
while true; do
    name="$(bspc query -D -d "$path" --names)"
    [ -z "$name" ] && exit
    if [ -n "${name%%_*}" ]; then
        echo "$path"
        exit
    else
        path="$path#$1.local.occupied"
    fi
done
