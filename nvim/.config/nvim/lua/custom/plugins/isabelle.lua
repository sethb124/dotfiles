return {
  {
    'Treeniks/isabelle-lsp.nvim',
    ft = 'isabelle',
    config = function()
      vim.lsp.enable 'isabelle'
      -- shrink output window so it's not 50% of the screen
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'isabelle_output',
        callback = function(args)
          vim.schedule(function()
            local win = vim.fn.bufwinid(args.buf)
            vim.wo[win].winfixheight = true
            if win ~= -1 then
              vim.api.nvim_win_set_height(win, 10)
            end
          end)
        end,
      })
      -- hide output window when leaving isabelle file
      vim.api.nvim_create_autocmd('BufEnter', {
        callback = function(args)
          vim.schedule(function()
            local ft = vim.bo[args.buf].filetype
            local buf = vim.iter(vim.api.nvim_list_bufs()):find(function(buf)
              return vim.bo[buf].filetype == 'isabelle_output'
            end)
            if not buf then
              return
            end
            local win = vim.fn.bufwinid(buf)
            if ft == 'isabelle' then
              if win == -1 then
                vim.api.nvim_open_win(buf, false, {
                  split = 'below',
                  height = 10,
                })
              end
            elseif ft ~= 'isabelle_output' and win ~= -1 then
              vim.api.nvim_win_hide(win)
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
    ft = 'isabelle',
    -- only enable conceal for isabelle files
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          vim.wo.conceallevel = args.match == 'isabelle' and 2 or 0
        end,
      })
    end,
  },
}
