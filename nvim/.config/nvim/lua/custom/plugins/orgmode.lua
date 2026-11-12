return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = { 'org' },
  config = function()
    require('orgmode').setup {
      org_agenda_files = '~/todo.org',
      org_default_notes_file = '~/todo.org',
      org_startup_folded = 'showeverything',
      -- ui = {
      --   menu = {
      --     handler = function(data)
      --       local Menu = require 'nui.menu'
      --       local event = require('nui.utils.autocmd').event
      --       local options = {}
      --       for _, item in ipairs(data.items) do
      --         if item.key and item.label:lower() ~= 'quit' then
      --           table.insert(options, Menu.item(item.key .. ' - ' .. item.label))
      --         end
      --       end
      --
      --       local menu = Menu({
      --         position = '50%',
      --         size = {
      --           width = 60,
      --           height = 30,
      --         },
      --         border = {
      --           style = 'single',
      --           text = {
      --             top = data.title,
      --             top_align = 'center',
      --           },
      --         },
      --         win_options = {
      --           winhighlight = 'Normal:Normal',
      --         },
      --       }, {
      --         lines = options,
      --         -- keymap = {
      --         --   focus_next = { 'j', '<Down>', '<Tab>' },
      --         --   focus_prev = { 'k', '<Up>', '<S-Tab>' },
      --         --   close = { '<Esc>', '<C-c>' },
      --         --   submit = { '<CR>', '<Space>' },
      --         -- },
      --         -- on_close = function()
      --         --   print 'Menu Closed!'
      --         -- end,
      --         -- on_submit = function(item)
      --         --   print('Menu Submitted: ', item.text)
      --         -- end,
      --       })
      --
      --       -- mount the component
      --       menu:mount()
      --     end,
      --   },
      -- },
    }
    -- Experimental LSP support
    vim.lsp.enable 'org'
  end,
}
