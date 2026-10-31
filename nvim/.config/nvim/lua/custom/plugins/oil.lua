return {
  'stevearc/oil.nvim',
  lazy = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
      natural_order = true,
      is_always_hidden = function(name, _)
        return name == '..' or name == '.git'
      end,
    },
    win_options = {
      wrap = true,
    },
  },
  init = function()
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
      pattern = { 'oil://*' },
      callback = function()
        vim.keymap.set('n', 'j', function()
          if vim.fn.line '.' == vim.fn.line '$' then
            return 'gg'
          else
            return 'j'
          end
        end, { expr = true, buffer = true })
        vim.keymap.set('n', 'k', function()
          if vim.fn.line '.' == 1 then
            return 'G'
          else
            return 'k'
          end
        end, { expr = true, buffer = true })
      end,
    })
  end,
}
