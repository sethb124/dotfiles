return {
  {
    'benlubas/molten-nvim',
    version = '^1.0.0', -- use version <2.0.0 to avoid breaking changes
    build = ':UpdateRemotePlugins',
    init = function()
      vim.keymap.set('n', '<localleader>mi', ':MoltenInit<CR>', { silent = true, desc = '[I]nitialize the plugin' })
      vim.keymap.set('n', '<localleader>me', ':MoltenEvaluateOperator<CR>', { silent = true, desc = 'Evaluate [O]perator selection' })
      vim.keymap.set('n', '<localleader>ml', ':MoltenEvaluateLine<CR>', { silent = true, desc = 'Evaluate [L]ine' })
      vim.keymap.set('n', '<localleader>mr', ':MoltenReevaluateCell<CR>', { silent = true, desc = '[R]e-run cell' })
      vim.keymap.set('v', '<localleader>r', ':<C-u>MoltenEvaluateVisual<CR>gv', { silent = true, desc = '[R]un visual selection' })
      vim.keymap.set('n', '<localleader>os', ':noautocmd MoltenEnterOutput<CR>', { silent = true, desc = 'open output window' })
      vim.keymap.set('n', '<localleader>oh', ':MoltenHideOutput<CR>', { desc = 'close output window', silent = true })

      vim.g.molten_auto_open_output = false
      vim.g.molten_image_provider = 'image.nvim'
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_lines_off_by_1 = true
    end,
  },
  {
    -- see the image.nvim readme for more information about configuring this plugin
    '3rd/image.nvim',
    build = false,
    opts = {
      backend = 'kitty', -- whatever backend you would like to use
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
    },
  },
}
