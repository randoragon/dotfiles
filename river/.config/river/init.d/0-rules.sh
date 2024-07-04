#!/bin/sh

# Tags
riverctl rule-add -app-id 'firefox' tags $((1 << 9))
riverctl rule-add -app-id 'thunderbird' tags $((1 << 10))
riverctl rule-add -app-id 'discord' tags $((1 << 11))

# Floats
riverctl rule-add -app-id 'floatme' float

# Server-side decorations
riverctl rule-add -app-id 'firefox' ssd
riverctl rule-add -app-id 'zathura*' ssd
