#!/bin/bash
set -ex
input=$(ps -U seth -o ucmd |
    sort |
    uniq |
    ~/.dotfiles/scripts/bemenu)
if [[ -n $input ]]; then
    killall "$input"
fi
