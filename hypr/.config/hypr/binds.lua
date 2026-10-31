hl.bind(mainMod .. ' + Q', hl.dsp.exec_cmd(terminal))
hl.bind(
  mainMod .. ' + SHIFT + Q',
  hl.dsp.exec_cmd(terminal, { float = true, pin = true, size = '95%' })
)
hl.bind(mainMod .. ' + C', hl.dsp.window.close())
hl.bind(mainMod .. ' + V', hl.dsp.window.float { action = 'toggle' })
hl.bind(
  mainMod .. ' + F',
  hl.dsp.window.fullscreen { mode = 'maximized', action = 'toggle' }
)
hl.bind(mainMod .. ' + R', hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. ' + E', hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. ' + B', hl.dsp.exec_cmd(terminal .. ' btop'))
hl.bind(mainMod .. ' + H', hl.dsp.exec_cmd(scripts .. '/bluetooth.sh'))
hl.bind(mainMod .. ' + X', hl.dsp.exec_cmd(scripts .. '/kill.sh'))

hl.bind('PRINT', hl.dsp.exec_cmd 'hyprshot --clipboard-only -m window')
hl.bind('SHIFT + PRINT', hl.dsp.exec_cmd 'hyprshot --clipboard-only -m region')
hl.bind(mainMod .. ' + PRINT', function()
  hl.dispatch(
    hl.dsp.exec_cmd(
      'hyprshot --clipboard-only -m output -m ' .. hl.get_active_monitor().name
    )
  )
end)
hl.bind(mainMod .. ' + L', hl.dsp.exec_cmd 'hyprlock')
hl.bind(mainMod .. ' + SHIFT + L', hl.dsp.exec_cmd 'wlogout')
hl.bind(
  mainMod .. ' + P',
  hl.dsp.exec_cmd(scripts .. '/cycle_power_profile.sh')
)

hl.bind(mainMod .. ' + SHIFT + B', hl.dsp.exec_cmd 'killall waybar; waybar &')
hl.bind(
  mainMod .. ' + SHIFT + H',
  hl.dsp.exec_cmd 'killall hyprpaper; hyprpaper &'
)

hl.bind(mainMod .. ' + M', hl.dsp.layout 'addmaster')
hl.bind(mainMod .. ' + SHIFT + M', hl.dsp.layout 'removemaster')

hl.bind(mainMod .. ' + TAB', hl.dsp.layout 'cyclenext')
hl.bind(mainMod .. ' + SHIFT + TAB', hl.dsp.layout 'cycleprev')

hl.bind(mainMod .. ' + UP', hl.dsp.layout 'swapprev')
hl.bind(mainMod .. ' + LEFT', hl.dsp.layout 'swapprev')
hl.bind(mainMod .. ' + DOWN', hl.dsp.layout 'swapnext')
hl.bind(mainMod .. ' + RIGHT', hl.dsp.layout 'swapnext')

local function bind_resize(cmd, x, y)
  hl.bind(
    cmd,
    hl.dsp.window.resize { x = x, y = y, relative = true },
    { repeating = true }
  )
end
bind_resize(mainMod .. ' + CTRL + L', 10, 0)
bind_resize(mainMod .. ' + CTRL + H', -10, 0)
bind_resize(mainMod .. ' + CTRL + K', 0, 10)
bind_resize(mainMod .. ' + CTRL + J', 0, -10)
-- hl.bind(mainMod .. ' + SHIFT + R', hl.dsp.submap 'resize')
-- hl.define_submap('resize', function()
--   hl.bind('TAB', hl.dsp.layout 'cyclenext')
--   bind_resize('L', 10, 0)
--   bind_resize('H', -10, 0)
--   bind_resize('K', 0, 10)
--   bind_resize('J', 0, -10)
--   bind_resize('SHIFT + L', 50, 0)
--   bind_resize('SHIFT + H', -50, 0)
--   bind_resize('SHIFT + K', 0, 50)
--   bind_resize('SHIFT + J', 0, -50)
--   hl.bind('escape', hl.dsp.submap 'reset')
--   --hl.bind('catchall', hl.dsp.submap 'resize')
-- end)

hl.bind(mainMod .. ' + J', hl.dsp.focus { workspace = 'e+1' })
hl.bind(mainMod .. ' + K', hl.dsp.focus { workspace = 'e-1' })
hl.bind(mainMod .. ' + N', hl.dsp.focus { workspace = 'emptyn' })
hl.bind(mainMod .. ' + SEMICOLON', hl.dsp.focus { workspace = 'previous' })
hl.bind(mainMod .. ' + SHIFT + J', hl.dsp.window.move { workspace = '+1' })
hl.bind(mainMod .. ' + SHIFT + K', hl.dsp.window.move { workspace = '-1' })
hl.bind(mainMod .. ' + SHIFT + N', hl.dsp.window.move { workspace = 'emptyn' })
hl.bind(
  mainMod .. ' + SHIFT + SEMICOLON',
  hl.dsp.window.move { workspace = 'previous' }
)

for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. ' + ' .. key, hl.dsp.focus { workspace = i })
  hl.bind(mainMod .. ' + SHIFT + ' .. key, hl.dsp.window.move { workspace = i })
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. ' + mouse_down', hl.dsp.focus { workspace = 'e+1' })
hl.bind(mainMod .. ' + mouse_up', hl.dsp.focus { workspace = 'e-1' })

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. ' + mouse:272', hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. ' + mouse:273', hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
-- these always change volume to a multiple of 5
local vol =
  '$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk \'{print int($2 * 100 + 0.5)}\')'
local function vol_cmd(expr, pm)
  return string.format(
    'wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ $(bc <<< "%s")%%%s',
    expr,
    pm
  )
end
hl.bind(
  'XF86AudioRaiseVolume',
  hl.dsp.exec_cmd(vol_cmd('5 - (' .. vol .. ' % 5)', '+')),
  { locked = true, repeating = true }
)
hl.bind(
  'XF86AudioLowerVolume',
  hl.dsp.exec_cmd(vol_cmd('(' .. vol .. ' - 1) % 5 + 1', '-')),
  { locked = true, repeating = true }
)
hl.bind(
  'XF86AudioMute',
  hl.dsp.exec_cmd 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle',
  { locked = true, repeating = true }
)
hl.bind(
  'XF86AudioMicMute',
  hl.dsp.exec_cmd 'wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle',
  { locked = true, repeating = true }
)
hl.bind(
  'XF86MonBrightnessUp',
  hl.dsp.exec_cmd 'brightnessctl set 5%+',
  { locked = true, repeating = true }
)
hl.bind(
  'SHIFT + XF86MonBrightnessUp',
  hl.dsp.exec_cmd 'brightnessctl set 10%+',
  { locked = true, repeating = true }
)
hl.bind(
  'XF86MonBrightnessDown',
  hl.dsp.exec_cmd 'brightnessctl set 5%-',
  { locked = true, repeating = true }
)
hl.bind(
  'SHIFT + XF86MonBrightnessDown',
  hl.dsp.exec_cmd 'brightnessctl set 10%-',
  { locked = true, repeating = true }
)

-- Requires playerctl
hl.bind('XF86AudioNext', hl.dsp.exec_cmd 'playerctl next', { locked = true })
hl.bind(
  'XF86AudioPause',
  hl.dsp.exec_cmd 'playerctl play-pause',
  { locked = true }
)
hl.bind(
  'XF86AudioPlay',
  hl.dsp.exec_cmd 'playerctl play-pause',
  { locked = true }
)
hl.bind(
  'XF86AudioPrev',
  hl.dsp.exec_cmd 'playerctl previous',
  { locked = true }
)
