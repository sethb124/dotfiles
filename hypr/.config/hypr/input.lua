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
      tap_to_click = false,
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

-- thinkpad touchpad
hl.device {
  name = 'gxtp5100:00-27c6:01e0-touchpad',
  sensitivity = 0.4,
}

-- thinkpad trackpoint
hl.device {
  name = 'tpps/2-elan-trackpoint',
  sensitivity = -0.4,
  scroll_factor = 0.75,
}
