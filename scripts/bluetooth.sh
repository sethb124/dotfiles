#!/bin/bash
set -ex
mac=$(cat "$(dirname "${BASH_SOURCE[0]}")/mac")
if ! bluetoothctl devices Connected | grep -q "$mac"; then
    if ! (bluetoothctl devices Trusted | grep -q "$mac"); then
        notify-send "Pairing with $mac..."
        bluetoothctl --timeout 10 scan on
        bluetoothctl pair "$mac"
        bluetoothctl trust "$mac"
    fi
    notify-send "Connecting to $mac..."
    bluetoothctl connect "$mac"
    # wait for device to pair
    until bluetoothctl devices Connected | grep -q "$mac"; do sleep 1; done
    # adjust volume to the nearest 5
    volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d ' ' -f 2)
    wpctl set-volume @DEFAULT_AUDIO_SINK@ "$(bc <<<"$volume % .05")-"
    # notify-send "$mac connected"
else
    notify-send "$mac disconnected"
    bluetoothctl disconnect
fi
