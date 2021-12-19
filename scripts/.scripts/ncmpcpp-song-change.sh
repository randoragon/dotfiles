#!/usr/bin/sh

# This script is run every time ncmpcpp registers a song change.

# Dump now playing to a text file for other programs to read
printf "%s" "$(mpc current --format '%artist% - %title%    ·')    " >${XDG_CACHE_HOME:-~/.cache}/ncmpcpp-now-playing.txt
printf "%s" "$(mpc current --format '%title%    ·')    " >${XDG_CACHE_HOME:-~/.cache}/ncmpcpp-now-playing-title.txt
printf "%s" "$(mpc current --format '%artist%    ·')    " >${XDG_CACHE_HOME:-~/.cache}/ncmpcpp-now-playing-artist.txt
printf "%s" "$(mpc current --format '%album%    ·')    " >${XDG_CACHE_HOME:-~/.cache}/ncmpcpp-now-playing-album.txt

# SET ALBUM COVER AS WALLPAPER
#
# Uncomment the line below to activate:
switch_wallpaper=1
if [ -n "$switch_wallpaper" ]; then
    cachefile="${XDG_CACHE_HOME:-~/.cache}/ncmpcpp-albumart.jpg"
    mpdfpath="$(mpc current --format %file% --port "$MPD_PORT")"
    if mpc readpicture "$mpdfpath" >"$cachefile"; then
        xwallpaper --maximize "$cachefile"
    else
        rm -f -- "$cachefile"
        xwallpaper --zoom "${XDG_CONFIG_HOME:-~/.config}/wallpaper"
    fi
fi
