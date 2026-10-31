return {
  enabled = false,
  'eandrju/cellular-automaton.nvim',
  init = function()
    vim.keymap.set('n', '<Leader>mr', '<Cmd>CellularAutomaton make_it_rain<CR>')
  end,
}
