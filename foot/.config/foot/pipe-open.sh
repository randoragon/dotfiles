#!/bin/sh

# Writes stdin to a temporary file, opens the file for editing.
# The file is removed after the editor closes.

tmpf="$(mktemp --tmpdir foot-pipe.XXXXX)"
trap 'rm -f -- "$tmpf"' INT QUIT TERM EXIT

cat - >"$tmpf"
# shellcheck disable=SC2086
$TERMINAL $EDITOR -- "$tmpf"
