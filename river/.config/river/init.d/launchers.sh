#!/bin/sh

appmap () {
    riverctl map normal "$1" "$2" spawn "$3"
}

appmap Super         C      'snippet'
appmap Super+Shift   O      '~/.scripts/passcpy'
appmap Super+Control O      '~/.scripts/usercpy'
appmap Super+Shift   N      'note'
appmap Super+Control N      'note -e'
appmap Super+Control equal  '~/.scripts/pladd_select'

appmap Control+Alt D 'discord'
