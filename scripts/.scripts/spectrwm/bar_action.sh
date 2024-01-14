#!/bin/sh

datetime () {
    date +'%a %m/%d  %H:%M:+@fn=2;%S+@fn=0;'
}

gpg_expire () {
    epoch_expire=$(($(gpg -K --with-colons | grep '^\(sec\|ssb\)' | cut -d: -f7 | sort -n | head -n1)))
    epoch_now=$(($(date +%s)))
    if [ $epoch_now -ge $epoch_expire ]; then
        echo EXPIRED
    else
        n_left=$(((epoch_expire - epoch_now) / 3600))
        if [ $n_left -eq 0 ]; then
            echo '<1 hour'
            return
        elif [ $n_left -lt 24 ]; then
            printf '%u hour' "$n_left"
        else
            n_left=$((n_left / 24))
            printf '%u day' "$n_left"
        fi
        [ $n_left -ne 1 ] && printf s
    fi
}

storage () {
    rootfs=$((1024 * $(df --output=avail / | tail -n1)))
    homefs=$((1024 * $(df --output=avail /home | tail -n1)))
    printf '/ %s  ~ %s\n' \
        "$(numfmt --to iec --format %.1f "$rootfs")" \
        "$(numfmt --to iec --format %.1f "$homefs")"
}

volume () {
    if [ "$(pactl get-sink-mute @DEFAULT_SINK@)" = 'Mute: yes' ]; then
        printf 'M '
    else
        printf '++ '
    fi
    pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[0-9]\+%' | sort -nr | head -n1
}

i=0
while true; do
    [ $((i % (4 * 3600))) -eq 0 ] && {
        gpg_expire="$(gpg_expire)"
    }

    [ $((i % (4 * 10))) -eq 0 ] && {
        storage="$(storage)"
    }

    [ $((i % 4)) -eq 0 ] && {
        datetime="$(datetime)"
    }

    volume="$(volume)"

    printf '%s │ %s │ %s │ %s\n' "$volume" "$storage" "$gpg_expire" "$datetime"

    i=$((i + 1))
    sleep 0.25
done
