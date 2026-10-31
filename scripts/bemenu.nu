#!/bin/nu
use std/iter
let apps = (
  const csv = path self ./applications.csv;
  open $csv | update terminal {into bool}
)
let files = ls -as ~
  | get name
  | where $it starts-with .
  | where $it not-in [.config .dotfiles]
  | iter intersperse '-E'
  | let excludes
  | fd -H -t f -C ~ -E ...$excludes
  | LC_ALL=C ^sort -f
  | lines
const bemenu = path self bemenu
let input = $apps.name ++ $files | to text | run-external $bemenu
if $input not-in $apps.name {
  # fails on terminal applications
  # not sure how to fix right now
  xdg-open ($env.HOME | path join $input)
} else {
  let app = $apps | where name == $input | first
  if ($app.cmd | split words | first | which $in | is-empty) {
    notify-send ($app.name ++ ' is not installed')
  } else if $app.terminal {
    kitty --hold sh -c $app.cmd
  } else {
    exec sh -c $app.cmd
  }
}
