#!/bin/sh

riverctl map normal None XF86MonBrightnessUp   spawn 'xbacklight -inc 5'
riverctl map normal None XF86MonBrightnessDown spawn 'xbacklight -dec 5'
