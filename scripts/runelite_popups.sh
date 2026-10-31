#!/bin/bash
set -ex

handle() {
  case $1 in
  openwindow*)
    event=${1%%>>*}
    data=${1##"$event">>}
    IFS=','
    read WINDOWADDRESS WORKSPACENAME WINDOWCLASS WINDOWTITLE <<<$data
    unset IFS
    if [ "$WINDOWCLASS" = 'net-runelite-client-RuneLite' ]; then
      hyprctl dispatch movetoworkspacesilent special:runelite, title:Exit, floating:1
    fi
    ;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
