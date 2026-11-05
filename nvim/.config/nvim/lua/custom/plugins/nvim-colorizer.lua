return {
  'catgoose/nvim-colorizer.lua',
  event = 'BufReadPre',
  opts = {
    options = {
      parsers = {
        css = true,
      },
      display = {
        priority = {
          default = 4096,
        },
      },
    },
  },
}
