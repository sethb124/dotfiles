hl.monitor {
  output = '',
  mode = 'preferred',
  position = 'auto',
  scale = '1.25',
}

mainMod = 'SUPER'
scripts = '~/dotfiles/scripts'
terminal = 'kitty'
menu = scripts .. '/bemenu.nu'
browser = 'zen-browser'
discordClient = 'equibop'
discordWithArgs = discordClient .. ' --wayland'

hl.on('hyprland.start', function()
  hl.exec_cmd 'waybar & swaync & hypridle & hyprpaper & hyprsunset'
  hl.exec_cmd(discordWithArgs)
end)

hl.env('XCURSOR_SIZE', '24')
hl.env('HYPRCURSOR_SIZE', '24')
hl.env('ELECTRON_OZONE_PLATFORM_HINT', 'wayland')

require 'appearance'
require 'binds'
require 'input'
require 'workspaces'
