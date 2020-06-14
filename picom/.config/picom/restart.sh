#!/bin/bash

killall picom
wait
sleep 0.5
picom --config ~/.config/picom/picom.conf
