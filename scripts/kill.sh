#!/bin/bash
set -ex
input=$(ps -U seth -o ucmd |
    sort |
    uniq |
    ~/.dotfiles/scripts/bemenu -p kill)
if [[ -n $input ]]; then
    killall "$input"
fi
