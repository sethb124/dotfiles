return {
  'L3MON4D3/LuaSnip',
  version = 'v2.*',
  opts = function()
    local ls = require 'luasnip'

    -- Load all snippets from the nvim/LuaSnip directory at startup
    require('luasnip.loaders.from_lua').lazy_load { paths = { '~/.config/nvim/LuaSnip/' } }

    vim.keymap.set({ 'i' }, '<Tab>', function()
      if ls.expandable() then
        ls.expand()
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, false, true), 'n', false)
      end
      -- if ls.expand_or_jumpable() then
      --   ls.expand_or_jump()
      -- else
      --   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, false, true), 'n', false)
      -- end
    end, { silent = true })

    vim.keymap.set({ 'i', 's' }, '<C-j>', function()
      if ls.jumpable(1) then
        ls.jump(1)
      end
    end, { silent = true })

    vim.keymap.set({ 'i', 's' }, '<C-k>', function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true })

    -- vim.keymap.set({ 'i', 's' }, '<Enter>', function()
    --   if ls.jumpable(1) then
    --     ls.jump(1)
    --   else
    --     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Enter>', true, false, true), 'n', false)
    --   end
    -- end, { silent = true })
    --
    -- vim.keymap.set({ 'i', 's' }, '<S-Enter>', function()
    --   if ls.jumpable(-1) then
    --     ls.jump(-1)
    --   end
    -- end, { silent = true })

    return {
      -- Enable autotriggered snippets
      enable_autosnippets = true,
      -- Use Tab (or some other key if you prefer) to trigger visual selection
      store_selection_keys = '<Tab>',
      -- Make repeat nodes display at same time
      update_events = { 'TextChanged', 'TextChangedI' },
    }
  end,
}
