#!/bin/bash
set -ex
profile=$(gdbus call --system \
    --dest net.hadess.PowerProfiles \
    --object-path /net/hadess/PowerProfiles \
    --method org.freedesktop.DBus.Properties.Get \
    net.hadess.PowerProfiles ActiveProfile |
    awk -F "'" '{print $2}')

case "$profile" in
power-saver)
    next=balanced
    ;;
balanced)
    next=performance
    ;;
performance)
    next=power-saver
    ;;
esac

gdbus call --system \
    --dest net.hadess.PowerProfiles \
    --object-path /net/hadess/PowerProfiles \
    --method org.freedesktop.DBus.Properties.Set \
    net.hadess.PowerProfiles ActiveProfile \
    "<'$next'>"

notify-send "Power profile set to $next"
