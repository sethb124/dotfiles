return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    views = {
      notify = {
        border = {
          style = 'single',
        },
      },
      popup = {
        border = {
          style = 'single',
        },
      },
      cmdline_input = {
        border = {
          style = 'single',
        },
      },
      cmdline_popup = {
        position = {
          row = 16,
          col = '50%',
        },
        size = {
          width = 60,
          height = 'auto',
        },
        border = {
          style = 'single',
          padding = { 0, 1 },
        },
      },
      hover = {
        border = {
          -- style = 'single',
          style = 'none',
        },
      },
      popupmenu = {
        relative = 'editor',
        position = {
          row = 19,
          col = '50%',
        },
        size = {
          width = 60,
          height = 10,
        },
        border = {
          style = 'single',
          padding = { 0, 1 },
        },
      },
    },
    routes = {
      {
        view = 'popup',
        filter = {
          event = 'msg_show',
          kind = 'shell_out',
        },
      },
    },
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    -- 'rcarriga/nvim-notify',
  },
}
