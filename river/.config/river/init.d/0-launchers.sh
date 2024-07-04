#!/bin/sh

appmap () {
    riverctl map normal "$1" "$2" spawn "$3"
}

appmap Super         C      'snippet'
appmap Super+Shift   O      '~/.scripts/passcpy'
appmap Super+Control O      '~/.scripts/usercpy'
appmap Super+Shift   Y      'note --bemenu'
appmap Super+Control Y      'note --bemenu -e'
appmap Super+Control equal  '~/.scripts/pladd_select'

appmap Control+Alt H "$TERMINAL -W 150x45 -a floatme htop"
appmap Control+Alt D 'discord'
appmap Control+Alt M "$TERMINAL ncmpcpp"
appmap Control+Alt N "$TERMINAL newsraft"
appmap Control+Alt Slash "$TERMINAL qalc"

appmap Control+Alt T "$TERMINAL $EDITOR ~/Sync/todo"
appmap Control+Alt B ~/.scripts/book
