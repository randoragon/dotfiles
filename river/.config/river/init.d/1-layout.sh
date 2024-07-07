#!/bin/sh

# Layout mappings
riverctl map normal Super A send-layout-cmd rivercarro 'main-location-cycle left,monocle'
riverctl map normal Super Z send-layout-cmd rivercarro 'main-location-cycle top,monocle'

# Ratio mappings
riverctl map -repeat normal Super H send-layout-cmd rivercarro 'main-ratio -0.025'
riverctl map -repeat normal Super L send-layout-cmd rivercarro 'main-ratio +0.025'

# Master count mappings
riverctl map normal Super+Shift I send-layout-cmd rivercarro 'main-count -1'
riverctl map normal Super+Shift U send-layout-cmd rivercarro 'main-count +1'

riverctl default-layout rivercarro
rivercarro -per-tag -main-ratio 0.55 &
