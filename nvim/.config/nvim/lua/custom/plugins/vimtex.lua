return {
  'lervag/vimtex',
  lazy = false, -- we don't want to lazy load VimTeX
  init = function()
    -- VimTeX configuration goes here, e.g.
    -- vim.g.vimtex_view_method = 'zathura_simple'
    vim.g.vimtex_view_method = 'sioyek'
    vim.g.vimtex_quickfix_ignore_filters = { 'Underfull \\hbox', 'Overfull \\hbox' }
    vim.g.vimtex_quickfix_open_on_warning = 0
    vim.g.vimtex_matchparen_enabled = 0
    vim.g.vimtex_indent_lists = {}
    vim.g.vimtex_imaps_enabled = 0
    vim.g.vimtex_mappings_disable = { i = { ']]' } }
    -- local delim_list = vim.g.vimtex_delim_list
    -- delim_list = {
    --   delim_math = {
    --     name = {
    --       { '(', ')' },
    --       { '[', ']' },
    --       { '\\{', '\\}' },
    --       { '\\langle', '\\rangle' },
    --       { '\\lbrace', '\\rbrace' },
    --       { '\\lvert', '\\rvert' },
    --       { '\\lVert', '\\rVert' },
    --       { '\\lfloor', '\\rfloor' },
    --       { '\\lceil', '\\rceil' },
    --       { '\\ulcorner', '\\urcorner' },
    --     },
    --   },
    -- }
    -- vim.g.vimtex_delim_list = delim_list
  end,
}
