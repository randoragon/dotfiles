#!/bin/sh

BATTERY_DUNSTID=82147924
BATTERY_TMPF="$(mktemp --tmpdir "spectrwm_bar_power.$(whoami).XXXXX")"
echo 100 >"$BATTERY_TMPF"

# shellcheck disable=SC2064
trap "rm -f -- '$BATTERY_TMPF'; exit" INT QUIT EXIT HUP TERM

battery () {
    for path in /sys/class/power_supply/BAT?; do
        [ ! -d "$path" ] && return

        case "$(cat -- "$path/status")" in
            Charging) printf '^' ;;
            Discharging) printf 'v' ;;
        esac

        perc=$(($(cat -- "$path/capacity")))
        perc_prev=$(($(cat -- "$BATTERY_TMPF")))
        [ -n "$perc" ] && {
            printf '%s%%' "$perc"
            if [ $perc -le 15 ] && [ $perc_prev -gt 15 ]; then
                dunstify -r $BATTERY_DUNSTID -i battery -u critical "Battery Low [$perc%]"
            elif [ $perc -le 5 ] && [ $perc_prev -gt $perc ]; then
                dunstify -r $BATTERY_DUNSTID -i battery -u critical "Battery Low [$perc%]"
            fi
            echo "$perc" >"$BATTERY_TMPF"
        }

        break  # Only care about the first battery, if any
    done
}

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
    printf '/ %s' \
        "$(numfmt --to iec --format %.1f "$rootfs")"
    [ $homefs -ne $rootfs ] && {
        printf '  ~ %s' \
            "$(numfmt --to iec --format %.1f "$homefs")"
    }
}

volume () {
    if [ "$(pactl get-sink-mute @DEFAULT_SINK@)" = 'Mute: yes' ]; then
        printf 'X '
    else
        printf '> '
    fi
    pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[0-9]\+%' | sort -nr | head -n1
}

i=0
while true; do
    [ $((i % 3600)) -eq 0 ] && {
        gpg_expire="$(gpg_expire)"
    }

    [ $((i % 10)) -eq 0 ] && {
        storage="$(storage)"
        battery="$(battery)"
    }

    datetime="$(datetime)"
    volume="$(volume)"

    if [ -n "$battery" ]; then
        printf ' │ %s' "$volume" "$storage" "$gpg_expire" "$datetime" "$battery"
    else
        printf ' │ %s' "$volume" "$storage" "$gpg_expire" "$datetime"
    fi
    echo

    i=$((i + 1))
    sleep 1
done
