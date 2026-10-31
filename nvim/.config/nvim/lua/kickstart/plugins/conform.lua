return {
  'stevearc/conform.nvim',
  lazy = false,
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 1000,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    default_format_opts = {
      lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      rust = { 'rustfmt' },
      cpp = { 'astyle' },
      java = { 'astyle' },
      markdown = { 'prettierd' },
      -- Conform can also run multiple formatters sequentially
      python = { 'black', 'isort' },
      -- tex = { 'tex-fmt' },
      tex = { 'latexindent' },
      ocaml = { 'ocamlformat' },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      -- javascript = { { "prettierd", "prettier" } },
    },
    formatters = {
      astyle = {
        -- prepend_args = { '--indent-classes', '--indent-switches' },
        prepend_args = { '--indent-modifiers', '--indent-switches', '--indent-labels', '-s2' },
      },
      latexindent = {
        prepend_args = { '-l=/home/seth/.config/latexindent/indentconfig.yaml' },
      },
      black = {
        prepend_args = { '--skip-string-normalization', '--line-length', '79' },
      },
      -- ['tex-fmt'] = {
      --   prepend_args = { '-n' },
      -- },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
