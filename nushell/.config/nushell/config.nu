use std *

# config options
$env.config.show_banner = false
$env.config.edit_mode = 'vi'
$env.config.cursor_shape.emacs = 'line'
$env.config.cursor_shape.vi_insert = 'line'
$env.config.cursor_shape.vi_normal = 'block'
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = ""
$env.config.use_kitty_protocol = true
$env.config.table.mode = 'single'
$env.config.table.index_mode = 'auto'
$env.config.datetime_format.table = '%b %d %Y %R'
$env.config.highlight_resolved_externals = true
$env.config.color_config = { shape_external: lr, shape_external_resolved: ub, shape_internalcall: ub }
$env.config.completions.algorithm = 'substring'
$env.config.history.file_format = 'sqlite'
$env.config.history.isolation = true
$env.EDITOR = 'nvim'

# aliases
alias v = nvim
alias ff = fastfetch
alias y = yazi
alias zen = zen-browser
alias o = xdg-open
def hy [] {
  cd ~/.config/hypr
  ^$env.EDITOR hyprland.lua
}

# keybinds
$env.config.keybindings ++= [{
  modifier: control
  keycode: char_u
  mode: vi_insert
  event: { edit: cutfromstart }
}]
$env.config.keybindings ++= [{
  modifier: control
  keycode: char_k
  mode: vi_insert
  event: { edit: killline }
}]

# $env.PROMPT_MULTILINE_INDICATOR = {
#   let p = do $env.PROMPT_COMMAND
#   | ansi strip
#   | str replace -ar . ' '
#   | str replace ' ' (starship prompt --continuation)
#   commandline set-prompt -m $p
# }

# etc.
mkdir ($nu.data-dir | path join 'vendor/autoload')
starship init nu | save -f ($nu.data-dir | path join 'vendor/autoload/starship.nu')
$env.PATH ++= ["~/.ghcup/bin", '~/.cabal/bin']
source ~/.zoxide.nu
source ./git-completions.nu
