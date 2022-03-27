#!/bin/sh

# Cycles between all floating clients in the
# current tag.
#
# This is an alternative implementation. The original cycle_floating.sh
# script is pretty sluggish, because hlwm doesn't provide immediate
# information about the visible floating clients on the current tag and
# so it is necessary to filter that information manually.
# And so I wanted to try this alternative approach to see if it would
# be any better. It's way worse due to scalability issues, messing up
# window focus history and causing flicker all the time. Still, I wrote
# it, so I don't want to delete it in case i think of some way to
# improve it or need it for something else.
#
# Usage:
#     cycle_floating.sh DIRECTION
# DIRECTION is a number by which to cycle, can be negative.

hc () {
    herbstclient "$@"
}

[ "$1" = 0 ] && exit

step=1
[ "$1" -lt 0 ] && step=-1

count=0
goal="${1#-}"
first="$(hc get_attr clients.focus.winid)"
while true; do
    hc chain , cycle_all --skip-invisible $step \
             , compare clients.focus.floating = 1 && {
        count=$((count + 1))
        [ "$count" = "$goal" ] && break
    }
    hc compare clients.focus.winid = "$first" && break
done
