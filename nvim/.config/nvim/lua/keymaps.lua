-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<Left>', '')
vim.keymap.set('n', '<Right>', '')
vim.keymap.set('n', '<Up>', '')
vim.keymap.set('n', '<Down>', '')
vim.keymap.set('i', '<Left>', '')
vim.keymap.set('i', '<Right>', '')
vim.keymap.set('i', '<Up>', '')
vim.keymap.set('i', '<Down>', '')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Make CTRL+s save the file
vim.keymap.set('n', '<C-s>', '<Cmd>update<CR>')
vim.keymap.set('i', '<C-s>', '<Esc><Cmd>update<CR>')

vim.keymap.set('n', 'j', function()
  return vim.v.count == 0 and 'gj' or 'j'
end, { expr = true })
vim.keymap.set('n', 'k', function()
  return vim.v.count == 0 and 'gk' or 'k'
end, { expr = true })

vim.keymap.set('n', '<Leader>x', '<Cmd>bd<CR>', { desc = 'Delete buffer' })

vim.keymap.set('n', '<Leader>rl', function()
  require('luasnip.loaders.from_lua').load { paths = '~/.config/nvim/LuaSnip/' }
end, { desc = '[R]eload [L]uaSnip Snippets' })
vim.keymap.set('n', '<Leader>n', function()
  Snacks.notifier.show_history()
end, { desc = 'Show [N]otification History' })

vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

-- Disable marks
vim.keymap.set('n', 'm', '')

vim.api.nvim_create_user_command('ReloadSession', function()
  local tmp = '/tmp/Session.vim'
  vim.cmd('mksession! ' .. tmp .. ' | restart source ' .. tmp)
end, {})
vim.keymap.set('n', '<Leader>rs', '<Cmd>ReloadSession<CR>', { desc = '[R]eload Session' })

-- vim: ts=2 sts=2 sw=2 et
