vim.lsp.config('hls', {
  filetypes = { 'haskell', 'lhaskell' },
  settings = {
    haskell = {
      formattingProvider = 'fourmolu',
      cabalFormattingProvider = 'cabalfmt',
      -- plugin = {
      --   fourmolu = {
      --     config = {
      --       external = '/home/seth/.cabal/bin/fourmolu',
      --     },
      --   },
      -- },
    },
  },
})
vim.lsp.enable 'hls'

vim.lsp.config('ocamllsp', {
  cmd = { 'ocamllsp' },
  filetypes = {
    'ocaml',
    'ocaml.interface',
    'ocaml.menhir',
    'ocaml.ocamllex',
    'dune',
    'reason',
  },
  root_markers = {
    { 'dune-project', 'dune-workspace' },
    { '*.opam', 'esy.json', 'package.json' },
    '.git',
  },
  settings = {},
})
vim.lsp.enable 'ocamllsp'

vim.lsp.config('zls', {
  cmd = { 'zls' },
  filetypes = {
    'zig',
  },
})
vim.lsp.enable 'zls'

vim.lsp.enable 'nushell'
