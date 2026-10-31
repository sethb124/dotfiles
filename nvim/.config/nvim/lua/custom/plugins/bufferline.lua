return {
  'akinsho/bufferline.nvim',
  dependencies = 'nvim-tree/nvim-web-devicons',
  enabled = false,
  opts = {
    options = {
      show_buffer_close_icons = false,
      hover = {
        enabled = true,
        delay = 0,
        reveal = { 'close' },
      },
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'Neo-tree',
          text_align = 'center',
          separator = true,
        },
      },
      sort_by = 'extension',
    },
  },
}
