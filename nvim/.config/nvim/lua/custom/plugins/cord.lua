return {
  'vyfor/cord.nvim',
  build = ':Cord update',
  enabled = false,
  opts = function()
    local blacklist = {
      'Dragon Heist',
      'Curse of Strahd',
    }

    local projects = {
      'Dragon Heist',
      'Curse of Strahd',
      'Geometry',
      'Prob and Stats II',
      'Advanced Calc II',
      'Discrete Structures',
      'Database Systems',
    }

    local is_blacklisted = function(opts)
      -- return vim.tbl_contains(blacklist, opts.workspace)
      return vim.tbl_contains(blacklist, function(v)
        return string.find(opts.workspace_dir, v)
      end, { predicate = true })
    end

    local project_or_workspace = function(opts)
      for _, project in ipairs(projects) do
        if string.find(opts.workspace_dir, project) then
          return project
        end
      end
      return opts.workspace
    end

    return {
      idle = {
        enabled = true,
        show_status = false,
        ignore_focus = true,
        unidle_on_focus = false,
        smart_idle = false,
      },
      text = {
        viewing = function(opts)
          return is_blacklisted(opts) and 'Viewing a file' or ('Viewing ' .. opts.filename)
        end,
        editing = function(opts)
          return is_blacklisted(opts) and 'Editing a file' or ('Editing ' .. opts.filename)
        end,
        workspace = function(opts)
          return 'In ' .. project_or_workspace(opts)
        end,
      },
      timestamp = {
        enabled = true,
        reset_on_idle = true,
        reset_on_change = true,
      },
    }
  end,
}
