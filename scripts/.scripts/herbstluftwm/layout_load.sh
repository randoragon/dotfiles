#!/bin/sh
#
# Loads a layout from LAYOUT_DIR.

LAYOUT_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/herbstluftwm/layouts"

[ ! -d "$LAYOUT_DIR" ] && exit

name="$(find "$LAYOUT_DIR/" -type f -exec basename {} \; | sort \
      | dmenu -f -l 10 -p 'Load Layout:' | sed 's/^[0-9]\+\s*//')"
[ -z "$name" ] || [ ! -r "$LAYOUT_DIR/$name" ] && exit

herbstclient load "$(cat -- "$LAYOUT_DIR/$name")"
