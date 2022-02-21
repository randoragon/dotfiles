#!/bin/sh

WARN=15
CRIT=5
DUNST_ID=82147924
SFX=/home/pcache/dotfiles/.other/notification2.mp3
BAR_H=20
DIR=/sys/class/power_supply/BAT0
INTERVAL=5

notify () {
    remaining="$(acpi | grep -o '[0-9:]* remaining')"
    dunstify -r $DUNST_ID -i battery -u critical "Battery Low [$1%]" "$remaining"
    mpv --no-terminal -- "$SFX" >/dev/null 2>&1 &
}

prev=100
while true; do
    capacity="$(cat -- "$DIR/capacity")"
    status="$(cat -- "$DIR/status")"

    if [ "$status" = Charging ]; then
        icon=
        sat="$(( 80 + (capacity * 175 / 100) ))"
        col="$(printf '#50%02x%02x' "$sat" "$sat")"
    else
        icon=
        red="$(( 255 - (capacity * 175 / 100) ))"
        green="$(( 80 + (capacity * 175 / 100) ))"
        col="$(printf '#%02x%02x50' "$red" "$green")"
    fi

    if [ "$capacity" -le "$CRIT" ]; then
        [ "$status" != "Charging" ] && [ "$prev" -gt "$capacity" ] && {
            notify "$capacity"
        }
    elif [ "$capacity" -le "$WARN" ]; then
        [ "$status" != "Charging" ] && [ "$prev" -gt "$WARN" ] && {
            notify "$capacity"
        }
    fi

    prev="$capacity"
    echo "%{F$col}  $icon $capacity% "
    sleep $INTERVAL
done
