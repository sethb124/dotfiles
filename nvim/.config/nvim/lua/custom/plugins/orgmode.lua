return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = { 'org' },
  config = function()
    require('orgmode').setup {
      org_agenda_files = '~/todo.org',
      org_default_notes_file = '~/todo.org',
    }
    -- Experimental LSP support
    vim.lsp.enable 'org'
  end,
}
