-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  -- Optional dependency
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function(_, opts)
    local npairs = require 'nvim-autopairs'
    local cond = require 'nvim-autopairs.conds'
    npairs.setup(opts)
    -- disable ` autopairing on tex files
    for _, r in ipairs(npairs.get_rules '`') do
      r:with_pair(cond.not_filetypes { 'tex' })
    end
  end,
}
