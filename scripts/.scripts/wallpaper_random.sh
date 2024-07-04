#!/bin/sh

WALLPAPER_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/wallpapers"

pick="$(find "$WALLPAPER_DIR" -type f | shuf -n 1)"
cp -- "$pick" ~/.config/wallpaper
swww img -t none ~/.config/wallpaper
