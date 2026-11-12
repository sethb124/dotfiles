#!/bin/bash
set -ex
if pgrep -x hypridle; then
    pkill -x hypridle
    notify-send 'Hypridle disabled'
else
    hypridle &
    notify-send 'Hypridle enabled'
fi
