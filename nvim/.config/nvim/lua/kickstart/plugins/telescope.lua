-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  opts = function()
    require('telescope').setup {
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- the most complicated possible way of changing telescope's ui
    -- I barely understand what this does, but it works
    local Layout = require 'nui.layout'
    local TSLayout = require 'telescope.pickers.layout'

    local function make_popup(options)
      local popup = require 'nui.popup'(options)
      function popup.border:change_title(title)
        popup.border.set_text(popup.border, 'top', title)
      end
      return TSLayout.Window(popup)
    end

    require('telescope').setup {
      defaults = {
        layout_strategy = 'flex',
        layout_config = {
          horizontal = {
            size = {
              width = '80%',
              height = '90%',
            },
          },
          vertical = {
            size = {
              width = '90%',
              height = '90%',
            },
          },
        },
        create_layout = function(picker)
          local border = {
            results = {
              top_left = '┌',
              top = '─',
              top_right = '┬',
              right = '│',
              bottom_right = '',
              bottom = '',
              bottom_left = '',
              left = '│',
            },
            results_patch = {
              minimal = {
                top_left = '┌',
                top_right = '┐',
              },
              horizontal = {
                top_left = '┌',
                top_right = '┬',
              },
              vertical = {
                top_left = '├',
                top_right = '┤',
              },
            },
            prompt = {
              top_left = '├',
              top = '─',
              top_right = '┤',
              right = '│',
              bottom_right = '┘',
              bottom = '─',
              bottom_left = '└',
              left = '│',
            },
            prompt_patch = {
              minimal = {
                bottom_right = '┘',
              },
              horizontal = {
                bottom_right = '┴',
              },
              vertical = {
                bottom_right = '┘',
              },
            },
            preview = {
              top_left = '┌',
              top = '─',
              top_right = '┐',
              right = '│',
              bottom_right = '┘',
              bottom = '─',
              bottom_left = '└',
              left = '│',
            },
            preview_patch = {
              minimal = {},
              horizontal = {
                bottom = '─',
                bottom_left = '',
                bottom_right = '┘',
                left = '',
                top_left = '',
              },
              vertical = {
                bottom = '',
                bottom_left = '',
                bottom_right = '',
                left = '│',
                top_left = '┌',
              },
            },
          }

          local results = make_popup {
            focusable = false,
            border = {
              style = border.results,
              text = {
                top = picker.results_title,
                top_align = 'center',
              },
            },
            win_options = {
              winhighlight = 'Normal:Normal',
            },
          }

          local prompt = make_popup {
            enter = true,
            border = {
              style = border.prompt,
              text = {
                top = picker.prompt_title,
                top_align = 'center',
              },
            },
            win_options = {
              winhighlight = 'Normal:Normal',
            },
          }

          local preview = make_popup {
            focusable = false,
            border = {
              style = border.preview,
              text = {
                top = picker.preview_title,
                top_align = 'center',
              },
            },
          }

          local box_by_kind = {
            vertical = Layout.Box({
              Layout.Box(preview, { grow = 1 }),
              Layout.Box(results, { grow = 1 }),
              Layout.Box(prompt, { size = 3 }),
            }, { dir = 'col' }),
            horizontal = Layout.Box({
              Layout.Box({
                Layout.Box(results, { grow = 1 }),
                Layout.Box(prompt, { size = 3 }),
              }, { dir = 'col', size = '55%' }),
              Layout.Box(preview, { size = '45%' }),
            }, { dir = 'row' }),
            minimal = Layout.Box({
              Layout.Box(results, { grow = 1 }),
              Layout.Box(prompt, { size = 3 }),
            }, { dir = 'col' }),
          }

          local function get_box()
            local strategy = picker.layout_strategy
            if strategy == 'vertical' or strategy == 'horizontal' then
              return box_by_kind[strategy], strategy
            end

            local height, width = vim.o.lines, vim.o.columns
            local box_kind = 'horizontal'
            if width < 100 then
              box_kind = 'vertical'
              if height < 40 then
                box_kind = 'minimal'
              end
            end
            return box_by_kind[box_kind], box_kind
          end

          local function prepare_layout_parts(layout, box_type)
            layout.results = results
            results.border:set_style(border.results_patch[box_type])

            layout.prompt = prompt
            prompt.border:set_style(border.prompt_patch[box_type])

            if box_type == 'minimal' then
              layout.preview = nil
            else
              layout.preview = preview
              preview.border:set_style(border.preview_patch[box_type])
            end
          end

          local function get_layout_size(box_kind)
            return picker.layout_config[box_kind == 'minimal' and 'vertical' or box_kind].size
          end

          local box, box_kind = get_box()
          local layout = Layout({
            relative = 'win',
            position = '50%',
            size = get_layout_size(box_kind),
          }, box)

          layout.picker = picker
          prepare_layout_parts(layout, box_kind)

          local layout_update = layout.update
          function layout:update()
            local box, box_kind = get_box()
            prepare_layout_parts(layout, box_kind)
            layout_update(self, { size = get_layout_size(box_kind) }, box)
          end

          return TSLayout(layout)
        end,
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>st', builtin.builtin, { desc = '[S]earch [S]elect telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>st', builtin.treesitter, { desc = '[S]earch [T]reesitter' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
-- vim: ts=2 sts=2 sw=2 et
