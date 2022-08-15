#!/usr/bin/sh

# This script is run every time ncmpcpp registers a song change.

# Dump now playing to a text file for other programs to read
printf "%s" "$(mpc current --format '%artist% - %title%    ·')    " \
    >"${XDG_CACHE_HOME:-~/.cache}/ncmpcpp-now-playing.txt"
printf "%s" "$(mpc current --format '%title%    ·')    " \
    >"${XDG_CACHE_HOME:-~/.cache}/ncmpcpp-now-playing-title.txt"
printf "%s" "$(mpc current --format '%artist%    ·')    " \
    >"${XDG_CACHE_HOME:-~/.cache}/ncmpcpp-now-playing-artist.txt"
printf "%s" "$(mpc current --format '%album%    ·')    " \
    >"${XDG_CACHE_HOME:-~/.cache}/ncmpcpp-now-playing-album.txt"

# SET ALBUM COVER AS WALLPAPER
#
# Uncomment the line below to activate:
switch_wallpaper=1
if [ -n "$switch_wallpaper" ]; then
    cachefile="${XDG_CACHE_HOME:-~/.cache}/ncmpcpp-albumart.jpg"
    mpdfpath="$(mpc current --format %file% --port "$MPD_PORT")"
    mpc readpicture "$mpdfpath" >"$cachefile"
    if file -- "$cachefile" | grep -qi 'image'; then
        tmp="$(mktemp)"
        h=$(magick "$cachefile" -format '%h' info:)
        newh="$(echo "scale=0; $h * 1.1 / 1" | bc)"
        convert "$cachefile" +write mpr:ORIG \
            \( \
                mpr:ORIG -resize 320x180^ -filter Gaussian -blur 0x4 \
                -gravity Center -crop 320x180+0+0 \
                -resize 1920x"$newh" +write mpr:BLUR \
            \) \
            \( \
                mpr:BLUR mpr:ORIG -gravity center -composite \
                +write "$tmp" \
            \) null:
        xwallpaper --maximize "$tmp"
        rm -f -- "$tmp"
    else
        rm -f -- "$cachefile"
        xwallpaper --zoom "${XDG_CONFIG_HOME:-~/.config}/wallpaper"
    fi
fi


# KEEP TRACK OF PER-SONG PLAY COUNT
#
# The script will only increment if a given track plays for >=20 seconds.
#
# Uncomment the line below to enable
keep_count=1
if [ -n "$keep_count" ]; then
    file="$(mpc current --format %file%)"

    # If the song changes in less than 20 seconds, don't increment
    # Yes, this means songs that have a <20s duration will always
    # be omitted, but I don't really care about enumerating such songs.
    # Due to the waiting, run this part in a subshell.
    (
        sleep 20
        [ "$(mpc current --format %file%)" != "$file" ] && exit
        plrare bump "$file"
    ) &
fi
