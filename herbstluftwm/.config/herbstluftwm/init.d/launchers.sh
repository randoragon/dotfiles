#!/bin/sh

MOD="${MOD:-Super}"

appmap () {
    keys="$1"
    shift
    herbstclient keybind "$keys" spawn "$@"
}

appmap "$MOD"+Return        st
appmap "$MOD"+o             dmenu_run
appmap "$MOD"+g             ~/.scripts/mousemode-run
appmap "$MOD"+c             snippet
appmap "$MOD"+Shift+o       ~/.scripts/passcpy
appmap "$MOD"+Control+o     ~/.scripts/usercpy
appmap "$MOD"+Shift+n       note --dmenu
appmap "$MOD"+Control+n     note --dmenu -e
appmap "$MOD"+Control+equal ~/.scripts/pladd_select
appmap "$MOD"+Shift+slash   groff -ms -t -T pdf -dpaper=a3l -P-pa3 -P-l ~/dotfiles/.other/shortcuts.ms \| zathura --mode=fullscreen -
appmap Control+Alt+i        st -e lf
appmap Control+Alt+w        ~/.scripts/surfbm
appmap Control+Alt+d        discord
appmap Control+Alt+f        fsearch
appmap Print                flameshot gui
