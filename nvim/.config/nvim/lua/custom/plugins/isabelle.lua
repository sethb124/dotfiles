return {
  {
    'Treeniks/isabelle-lsp.nvim',
    config = function()
      vim.lsp.enable 'isabelle'
      -- shrink output split so it's not 50% of the screen
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'isabelle_output',
        callback = function(args)
          vim.schedule(function()
            vim.wo.winfixheight = true
            local win = vim.fn.bufwinid(args.buf)
            if win ~= -1 then
              vim.api.nvim_win_set_height(win, 10)
            end
          end)
        end,
      })
      return {
        isabelle_path = '/opt/isabelle/bin/isabelle',
      }
    end,
  },
  {
    'Treeniks/isabelle-syn.nvim',
  },
}
