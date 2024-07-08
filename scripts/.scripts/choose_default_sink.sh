#!/bin/sh

# Displays an interactive bemenu with all PipeWire sinks listed.
# Sets the chosen sink as the new default.
#
# Dependencies:
# - pw-dump
# - pactl
# - bemenu
# - jq

current_sink="$(pactl get-default-sink)"

pw_dump="$(pw-dump)"

# List all sinks in an 'id   description' format, but with the current default sink at the very bottom.
options="$(printf '%s' "$pw_dump" | jq -r \
    "map(select(.type == \"PipeWire:Interface:Node\" and .info.props.\"media.class\" == \"Audio/Sink\" and .info.props.\"node.name\" != \"$current_sink\")).[]
    | [\"\", .id, .info.props.\"node.description\"]
    | @tsv")
    $(printf '%s' "$pw_dump" | jq -r \
    "map(select(.type == \"PipeWire:Interface:Node\" and .info.props.\"media.class\" == \"Audio/Sink\" and .info.props.\"node.name\" == \"$current_sink\")).[]
    | [\"*\", .id, .info.props.\"node.description\"]
    | @tsv")"

# Obtain new sink id from user
sel="$(echo "$options" | bemenu -i -c -W0.5 -l20 -B5 -R10 -p 'Default Sink')"
sink_id="${sel#*	}"
sink_id=$((${sink_id%%	*}))

new_sink="$(printf '%s' "$pw_dump" | jq -r "map(select(.id == $sink_id)).[0].info.props.\"node.name\"")"
pactl set-default-sink "$new_sink"
