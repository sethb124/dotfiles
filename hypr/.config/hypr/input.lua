hl.config {
  input = {
    kb_layout = 'us',
    kb_variant = '',
    kb_model = '',
    -- kb_options = 'altwin:swap_alt_win, caps:swapescape, caps:ctrl_modifier',
    kb_options = 'altwin:swap_alt_win',
    kb_rules = '',
    follow_mouse = 1,
    sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
    touchpad = {
      natural_scroll = false,
      disable_while_typing = true,
    },
    scroll_method = 'on_button_down',
    scroll_button = 274, -- middle mouse button
    -- force_no_accel = true,
  },
}

hl.gesture {
  fingers = 3,
  direction = 'horizontal',
  action = 'workspace',
}

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
-- These names are found by running `hyprctl devices`

-- latitude 7490
hl.device {
  name = 'dell081c:00-044e:121f-',
  sensitivity = 0.2,
}

hl.device {
  name = 'dell081c:00-044e:121f-mouse',
  sensitivity = -0.2,
}

-- thinkpad l14 gen 2
hl.device {
  name = 'synps/2-synaptics-touchpad',
  sensitivity = 0.7,
}

hl.device {
  name = 'gxtp5100:00-27c6:01e0-touchpad',
  sensitivity = 0.4,
}

hl.device {
  name = 'tpps/2-elan-trackpoint',
  sensitivity = -0.4,
  scroll_factor = 0.75,
}
