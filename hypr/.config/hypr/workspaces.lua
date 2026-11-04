-- Ignore maximize requests from all apps. You'll probably like this.
hl.window_rule {
  name = 'suppress-maximize-events',
  match = { class = '.*' },
  suppress_event = 'maximize',
}

-- Fix some dragging issues with XWayland
hl.window_rule {
  name = 'fix-xwayland-drags',
  match = {
    class = '^$',
    title = '^$',
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },
  no_focus = true,
}

-- Special workspaces
hl.config { misc = { close_special_on_empty = false } }

local special = {
  discord = {
    exec = discordWithArgs,
    class = discordClient,
    toggle = mainMod .. '+ D',
  },
  spotify = {
    exec = 'spotify --ozone-platform=wayland',
    class = 'Spotify',
    toggle = mainMod .. '+ S',
  },
  runelite = {
    exec = 'bolt',
    class = 'bolt-launcher',
    toggle = mainMod .. '+ A',
  },
}

-- create basic workspace and window rules for special workspaces
for name, ws in pairs(special) do
  hl.workspace_rule {
    workspace = 'special:' .. name,
  }
  hl.window_rule {
    match = {
      class = ws.class,
    },
    workspace = 'special:' .. name .. ' silent',
  }
  hl.bind(ws.toggle, hl.dsp.workspace.toggle_special(name))
end

-- create special workspace application if workspace is empty
hl.on('workspace.created', function(ws)
  if ws.special and ws.is_empty then
    hl.exec_cmd(special[ws.name:match '^special:(.*)'].exec)
  end
end)

-- extra runelite rules
hl.window_rule {
  match = {
    class = 'net-runelite-client-RuneLite',
  },
  workspace = 'special:runelite silent',
  pin = true,
  float = true,
}
hl.window_rule {
  match = {
    class = 'net-runelite-client-RuneLite',
    title = 'RuneLite',
  },
  maximize = true,
}
hl.window_rule {
  match = {
    class = '^(net-runelite-client-RuneLite)$',
    title = '^win(.*)$',
  },
  no_initial_focus = true,
}
