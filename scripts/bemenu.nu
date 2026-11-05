#!/bin/nu
let apps = (
  const csv = path self ./applications.csv;
  open $csv | update terminal {into bool}
)
let files = fd -t f -C ~ .
  | LC_ALL=C ^sort -f
  | lines
const menu = path self bemenu
let input = $apps.name ++ $files | to text | ^$menu -p open
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
