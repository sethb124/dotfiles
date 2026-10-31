return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  build = 'cd app && npm install && git restore .',
  init = function()
    vim.g.mkdp_filetypes = { 'markdown' }
    vim.g.mkdp_auto_start = false
    vim.g.mkdp_auto_close = false
    vim.g.mkdp_combine_preview = true
    -- not sure if I can make this lua but idgaf at this point
    -- FIX: yea for some reason this broke idk why it's gay
    -- vim.cmd [[
    --   function OpenMarkdownPreview(url)
    --     execute 'silent ! firefox-nightly --new-window ' . a:url
    --   endfunction
    --   let g:mkdp_browserfunc = 'OpenMarkdownPreview'
    -- ]]
  end,
  ft = { 'markdown' },
}
