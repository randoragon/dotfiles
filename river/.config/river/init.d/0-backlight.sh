#!/bin/sh

riverctl map normal None XF86MonBrightnessUp   spawn 'brightnessctl set -- +5%'
riverctl map normal None XF86MonBrightnessDown spawn 'brightnessctl set -- -5%'
