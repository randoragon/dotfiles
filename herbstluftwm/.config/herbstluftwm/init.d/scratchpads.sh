#!/bin/sh

# Requires my custom scratchpad.sh script.

MOD="${MOD:-Super}"

sp () {
    key="$1" name="$2"
    shift 2
    herbstclient keybind "$MOD"+"$key"         spawn ~/.scripts/herbstluftwm/scratchpad.sh "$name" toggle "$@"
    herbstclient keybind "$MOD"+Control+"$key" spawn ~/.scripts/herbstluftwm/scratchpad.sh "$name" remap  "$@"
}

sp "$MOD"+space sp_term  st -n sp_term
sp "$MOD"+m     sp_music st -n sp_music ncmpcpp
sp "$MOD"+n     sp_news  st -n sp_news dualboat
