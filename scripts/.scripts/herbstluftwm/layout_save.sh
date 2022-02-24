#!/bin/sh

# Saves the frame-only layout to LAYOUT_DIR.
# All window ids are filtered out.

LAYOUT_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/herbstluftwm/layouts"
[ ! -d "$LAYOUT_DIR" ] && exit

layout="$(herbstclient dump | sed 's/ 0x[0-9]\+//g')"

name="$(find "$LAYOUT_DIR/" -type f -exec basename {} \; | sort \
      | dmenu -f -l 5 -p 'Name Layout:')"
[ -z "$name" ] && exit

while [ -e "$LAYOUT_DIR/$name" ]; do
    ans="$(printf 'Y\nN (ESC)' | dmenu -i -p "'$name' already exists. Overwrite?")"
    [ "$ans" = Y ] && break

    name="$(find "$LAYOUT_DIR/" -type f -exec basename {} \; | sort \
          | dmenu -f -l 5 -p 'Name Layout:')"
    [ -z "$name" ] && exit
done

echo "$layout" >"$LAYOUT_DIR/$name"
