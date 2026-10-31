return {
  'mikesmithgh/kitty-scrollback.nvim',
  lazy = true,
  cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth', 'KittyScrollbackGenerateCommandLineEditing' },
  event = { 'User KittyScrollbackLaunch' },
  version = '*', -- latest stable version, may have breaking changes if major version changed
  -- config = function()
  --   require('kitty-scrollback').setup()
  -- end,
  opts = {
    myconfig = {
      kitty_get_text = {
        ansi = false,
      },
    },
  },
}
