#!/usr/bin/sh

# This script is run every time ncmpcpp registers a song change.

# Dump now playing to a text file for other programs to read
printf "%s" "$(mpc current --format '%artist% - %title%')    " >${XDG_CACHE_HOME:-~/.cache}/ncmpcpp-now-playing.txt

# SET ALBUM COVER AS WALLPAPER
#
# Uncomment the line below to activate:
# switch_wallpaper=1
if [ -n "$switch_wallpaper" ]; then
    mroot=~/Music
    cachefile="${XDG_CACHE_HOME:-~/.cache}/ncmpcpp-albumart.jpg"
    fpath="${mroot}/$(mpc current --format %file% --port "$MPD_PORT")"
    [ ! -r "$fpath" ] && exit 1
    if ffmpeg -y -i "$fpath" "$cachefile"; then
        xwallpaper --maximize "$cachefile"
    else
        xwallpaper --zoom "${XDG_CONFIG_HOME:-~/.config}/wallpaper"
    fi
fi
