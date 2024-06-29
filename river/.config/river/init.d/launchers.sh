#!/bin/sh

appmap () {
    riverctl map normal "$1" "$2" spawn "$3"
}

appmap Super         G      '~/.scripts/mousemode-run'
appmap Super         C      'snippet'
appmap Super+Shift   O      '~/.scripts/passcpy'
appmap Super+Control O      '~/.scripts/usercpy'
appmap Super+Shift   N      'note'
appmap Super+Control N      'note -e'
appmap Super+Control equal  '~/.scripts/pladd_select'

riverctl declare-mode launcher
riverctl map normal   Super 0      enter-mode launcher
riverctl map launcher None  Q enter-mode normal

launcher () {
    riverctl map launcher None "$1" spawn "$2"
}

launcher W '~/.scripts/surfbm'
launcher D 'discord'
