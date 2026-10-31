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

-- discord
hl.workspace_rule {
  workspace = 'special:discord',
  on_created_empty = discordWithArgs,
}
hl.window_rule {
  match = {
    class = discordClient,
  },
  workspace = 'special:discord silent',
}
hl.bind(mainMod .. ' + D', hl.dsp.workspace.toggle_special 'discord')

-- spotify
hl.workspace_rule {
  workspace = 'special:spotify',
  on_created_empty = 'spotify --ozone-platform=wayland',
}
hl.window_rule {
  match = {
    class = 'spotify',
  },
  workspace = 'special:spotify silent',
}
hl.bind(mainMod .. ' + S', hl.dsp.workspace.toggle_special 'spotify')

-- runelite
hl.workspace_rule {
  workspace = 'special:runelite',
  on_created_empty = 'bolt',
}
hl.window_rule {
  match = {
    title = 'Bolt Launcher',
  },
  workspace = 'special:runelite silent',
}
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
hl.bind(mainMod .. ' + A', hl.dsp.workspace.toggle_special 'runelite')
