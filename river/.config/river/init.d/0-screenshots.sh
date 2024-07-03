#!/bin/sh

mkdir -p -- "$GRIM_DEFAULT_DIR"

riverctl map normal None Print spawn 'slurp | grim -g - - | swappy -f -'
riverctl map normal Control Print spawn 'grim'
