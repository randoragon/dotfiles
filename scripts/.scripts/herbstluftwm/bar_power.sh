#!/bin/sh

FILE=/sys/class/power_supply/BAT0/power_now
INTERVAL=10  # update interval (in seconds)
COEFF=$((3600 / INTERVAL))

[ ! -r "$FILE" ] && exit

prev="$(cat -- "$FILE")"
while true; do
    curr="$(cat -- "$FILE")"

    # Cut last 3 digits instead of dividing; safer to do it this way,
    # since these numbers can get rather big.
    prev_mW="${prev%???}"
    curr_mW="${curr%???}"

    delta="$(((prev_mW - curr_mW) * COEFF))"
    echo " ${delta}mWh"

    prev="$curr"
    sleep $INTERVAL
done
