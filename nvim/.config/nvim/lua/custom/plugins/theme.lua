return {
  -- 'sainnhe/sonokai',
  -- lazy = false,
  -- priority = 1000,
  -- init = function()
  --   -- vim.g.sonokai_current_word = 'underline'
  --   vim.g.sonokai_better_performance = 1
  --   vim.g.sonokai_style = 'andromeda'
  --   vim.g.sonokai_colors_override = {
  --     bg0 = { '#000000', '235' },
  --     bg1 = { '#171717', '236' },
  --     bg2 = { '#2a2a2a', '236' },
  --     bg3 = { '#1a1a1a', '237' },
  --     bg4 = { '#303030', '237' },
  --   }
  --   vim.cmd.colorscheme 'sonokai'
  -- end,
  'eldritch-theme/eldritch.nvim',
  lazy = false,
  priority = 1000,
  init = function()
    vim.cmd.colorscheme 'eldritch'
  end,
  opts = {
    transparent = true,
    styles = {
      sidebars = 'normal',
      floats = 'normal',
    },
    sidebars = { 'qf', 'help' },
    on_colors = function(colors)
      colors.bg = '#000000'
      colors.bg_visual = '#000000'
      colors.bg_dark = '#000000'
      colors.bg_statusline = '#000000'
      colors.black = '#000000'
      -- colors.bg_highlight = '#171717'
      colors.terminal_black = '#000000'
      -- Pretty sure that these shouldn't be black
      -- colors.dark3 = '#000000'
      -- colors.dark5 = '#000000'
    end,
  },
}
