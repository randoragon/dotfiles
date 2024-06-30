#!/bin/sh

riverctl default-layout wideriver
wideriver \
    --layout                       left        \
    --layout-alt                   monocle     \
    --stack                        dwindle     \
    --count-master                 1           \
    --ratio-master                 0.55        \
    --no-smart-gaps                            \
    --inner-gaps                   10          \
    --outer-gaps                   10          \
    --border-width                 1           \
    --border-width-monocle         0           \
    --border-width-smart-gaps      0           \
    --log-threshold                info        \
    > "/tmp/wideriver.${XDG_VTNR}.${USER}.log" 2>&1 &

# Layout mappings
riverctl map normal Super 0 send-layout-cmd wideriver '--layout-toggle'
riverctl declare-mode wideriver-layout
riverctl map normal Super A enter-mode wideriver-layout
riverctl map wideriver-layout Super H spawn 'riverctl send-layout-cmd wideriver "--layout left"   && riverctl enter-mode normal'
riverctl map wideriver-layout Super J spawn 'riverctl send-layout-cmd wideriver "--layout bottom" && riverctl enter-mode normal'
riverctl map wideriver-layout Super K spawn 'riverctl send-layout-cmd wideriver "--layout top"    && riverctl enter-mode normal'
riverctl map wideriver-layout Super L spawn 'riverctl send-layout-cmd wideriver "--layout right"  && riverctl enter-mode normal'
riverctl map wideriver-layout Super M spawn 'riverctl send-layout-cmd wideriver "--layout monocle"   && riverctl enter-mode normal'
riverctl map wideriver-layout Q enter-mode normal
riverctl map wideriver-layout Escape enter-mode normal

# Ratio mappings
riverctl map -repeat normal Super H send-layout-cmd wideriver '--ratio -0.025'
riverctl map -repeat normal Super L send-layout-cmd wideriver '--ratio +0.025'

# Master count mappings
riverctl map normal Super+Shift Minus send-layout-cmd wideriver '--count -1'
riverctl map normal Super+Shift Equal send-layout-cmd wideriver '--count +1'
riverctl map normal Super+Shift U spawn 'riverctl send-layout-cmd wideriver "--count +1" && riverctl focus-view next'
riverctl map normal Super+Shift I spawn 'riverctl send-layout-cmd wideriver "--count -1" && riverctl focus-view previous'
