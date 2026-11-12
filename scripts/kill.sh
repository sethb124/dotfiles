#!/bin/bash
set -ex
input=$(ps -U $(id --user) -o ucmd |
    sort |
    uniq |
    ~/dotfiles/scripts/bemenu -p kill)
if [[ -n $input ]]; then
    pkill -x "$input"
fi
