#!/bin/sh

# Clear package cache
[ -n "$(command -v paccache)" ] && paccache -r
[ -n "$(command -v yay)" ]      && yay -Sca --noconfirm
