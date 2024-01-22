#!/bin/sh

# For copying a lot of links and storing them in a text file.

FILE=~/links.txt

prev=
while true; do
    sel="$(xclip -sel clip -o)"
    [ "$sel" != "$prev" ] && {
        echo "$sel" >>"$FILE"
        prev="$sel"
    }
    sleep 0.01666
done
