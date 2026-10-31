#!/bin/bash
set -ex
cd ~/.dotfiles
mkdir -p "$1/.config/$1"
cp -r "$HOME/.config/$1" "/tmp/$1_backup"
mv "$HOME/.config/$1" "$1/.config"
stow -t ~ "$1"
