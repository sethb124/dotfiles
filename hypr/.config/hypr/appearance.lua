hl.config {
  general = {
    gaps_in = 0,
    gaps_out = 0,

    border_size = 2,

    col = {
      active_border = 'rgba(37f499ff)',
      inactive_border = 'rgba(f9515dcc)',
    },

    -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
    resize_on_border = false,

    -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
    allow_tearing = false,

    layout = 'master',

    no_focus_fallback = true,
  },

  decoration = {
    rounding = 0,
    rounding_power = 2,

    -- Change transparency of focused and unfocused windows
    active_opacity = 1.0,
    inactive_opacity = 1.0,

    shadow = {
      enabled = false,
      range = 4,
      render_power = 3,
      color = 'rgba(ee1a1a1a)',
    },

    blur = {
      enabled = true,
      size = 8,
      passes = 1,
      vibrancy = 0.1696,
    },
  },

  animations = {
    enabled = true,
  },
}

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve(
  'easeOutQuint',
  { type = 'bezier', points = { { 0.23, 1 }, { 0.32, 1 } } }
)
hl.curve(
  'easeInOutCubic',
  { type = 'bezier', points = { { 0.65, 0.05 }, { 0.36, 1 } } }
)
hl.curve('linear', { type = 'bezier', points = { { 0, 0 }, { 1, 1 } } })
hl.curve(
  'almostLinear',
  { type = 'bezier', points = { { 0.5, 0.5 }, { 0.75, 1 } } }
)
hl.curve('quick', { type = 'bezier', points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve(
  'easy',
  { type = 'spring', mass = 1, stiffness = 238.1191, dampening = 24.21279333 }
)

hl.animation { leaf = 'global', enabled = true, speed = 10, bezier = 'default' }
hl.animation {
  leaf = 'border',
  enabled = true,
  speed = 5.39,
  bezier = 'easeOutQuint',
}
hl.animation { leaf = 'windows', enabled = true, speed = 4.79, spring = 'easy' }
-- hl.animation {
--   leaf = 'windows',
--   enabled = true,
--   speed = 7,
--   bezier = 'easeOutQuint',
-- }
hl.animation {
  leaf = 'windowsIn',
  enabled = true,
  speed = 4.1,
  spring = 'easy',
  style = 'popin 87%',
}
hl.animation {
  leaf = 'windowsOut',
  enabled = true,
  speed = 1.49,
  bezier = 'linear',
  style = 'popin 87%',
}
hl.animation {
  leaf = 'fadeIn',
  enabled = true,
  speed = 1.73,
  bezier = 'almostLinear',
}
hl.animation {
  leaf = 'fadeOut',
  enabled = true,
  speed = 1.46,
  bezier = 'almostLinear',
}
hl.animation { leaf = 'fade', enabled = true, speed = 3.03, bezier = 'quick' }
hl.animation {
  leaf = 'layers',
  enabled = true,
  speed = 3.81,
  bezier = 'easeOutQuint',
}
hl.animation {
  leaf = 'layersIn',
  enabled = true,
  speed = 4,
  bezier = 'easeOutQuint',
  style = 'fade',
}
hl.animation {
  leaf = 'layersOut',
  enabled = true,
  speed = 1.5,
  bezier = 'linear',
  style = 'fade',
}
hl.animation {
  leaf = 'fadeLayersIn',
  enabled = true,
  speed = 1.79,
  bezier = 'almostLinear',
}
hl.animation {
  leaf = 'fadeLayersOut',
  enabled = true,
  speed = 1.39,
  bezier = 'almostLinear',
}
hl.animation {
  leaf = 'workspaces',
  enabled = true,
  speed = 1.94,
  bezier = 'almostLinear',
  style = 'fade',
}
hl.animation {
  leaf = 'workspacesIn',
  enabled = true,
  speed = 1.21,
  bezier = 'almostLinear',
  style = 'fade',
}
hl.animation {
  leaf = 'workspacesOut',
  enabled = true,
  speed = 1.94,
  bezier = 'almostLinear',
  style = 'fade',
}
hl.animation { leaf = 'zoomFactor', enabled = true, speed = 7, bezier = 'quick' }

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config {
  dwindle = {
    preserve_split = true, -- You probably want this
  },
}

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config {
  master = {
    allow_small_split = true,
    new_status = 'slave',
    mfact = 0.5,
    smart_resizing = true,
  },
}

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config {
  scrolling = {
    fullscreen_on_one_column = true,
  },
}

hl.config {
  misc = {
    force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
    disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background. :(
    initial_workspace_tracking = 0,
  },
}

hl.config {
  cursor = {
    hide_on_key_press = true,
    inactive_timeout = 1,
  },
}

hl.config {
  xwayland = {
    force_zero_scaling = true,
  },
}

hl.window_rule {
  match = {
    workspace = 'w[t2-100]',
    fullscreen = true,
  },
  border_color = 'rgb(04d1f9)',
}
