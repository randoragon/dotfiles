#!/bin/sh

herbstclient keybind XF86MonBrightnessUp   spawn xbacklight -inc 5
herbstclient keybind XF86MonBrightnessDown spawn xbacklight -dec 5
herbstclient keybind Shift+XF86MonBrightnessUp   spawn xbacklight -set 100
herbstclient keybind Shift+XF86MonBrightnessDown spawn xbacklight -set 0
