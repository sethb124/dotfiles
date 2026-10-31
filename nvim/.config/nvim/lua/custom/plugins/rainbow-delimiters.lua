return {
  'hiphish/rainbow-delimiters.nvim',
  init = function()
    local rb = require 'rainbow-delimiters'
    vim.g.rainbow_delimiters = {
      blacklist = { 'latex' },
    }
  end,
}
