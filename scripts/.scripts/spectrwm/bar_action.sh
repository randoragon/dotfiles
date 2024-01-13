#!/bin/sh

storage () {
    rootfs=$((1024 * $(df --output=avail / | tail -n1)))
    homefs=$((1024 * $(df --output=avail /home | tail -n1)))
    printf ' %s   %s\n' \
        "$(numfmt --to iec --format %.1f "$rootfs")" \
        "$(numfmt --to iec --format %.1f "$homefs")"
}

datetime () {
    date +'%a %m/%d  %H:%M:+@fn=4;%S+@fn=0;'
}

volume () {
    if [ "$(pactl get-sink-mute @DEFAULT_SINK@)" = 'Mute: yes' ]; then
        icon=''
    else
        icon=''
    fi
    perc="$(pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[0-9]\+%' | sort -nr | head -n1)"
    echo "$icon $perc"
}

i=0
while true; do
    [ $((i % (4 * 10))) -eq 0 ] && {
        storage="$(storage)"
    }

    [ $((i % 4)) -eq 0 ] && {
        datetime="$(datetime)"
    }

    volume="$(volume)"

    printf '%s │ %s │ %s\n' "$volume" "$storage" "$datetime"

    i=$((i + 1))
    sleep 0.25
done
