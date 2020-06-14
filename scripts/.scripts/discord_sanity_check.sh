#!/bin/sh

# Checks if Discord is running - if not, throws a notification
# and restarts the program. I wrote this script because as of
# late Discord would randomly crash during voice calls.

while true; do
    if [ -z "$(pidof Discord)" ]; then
        dunstify "WARNING" "Discord crashed. Restarting..."
        discord 1>&- 2>&- &
    fi
    sleep 2
done
