return {
  {
    "lukas-reineke/virt-column.nvim",
    enabled = true,
    event   = 'VeryLazy',
    config = function ()
      require("virt-column").setup({
        char = '▕',
        virtcolumn = '+1',
        highlight = "VirtColumn",
        exclude = {
          filetypes = { 'gitsendemail' },
        },
      }) --▕│
    end
  },
  {
    "yamatsum/nvim-cursorline",
    cond = #vim.api.nvim_list_uis() > 0,
    config = function()
      require("nvim-cursorline").setup({
        cursorline = {
          enable   = true,
          timeout  = 500,
          number   = false,
        },
        cursorword   = {
          enable     = false,
          min_length = 3,
          hl         = { underline = true },
        },
      })
    end,
  },
  {
    'tzachar/highlight-undo.nvim',
    enabled = false,
    event = 'BufReadPre',
    opts = {
      duration = 300,
      undo = {
        hlgroup = 'HighlightUndo',
        mode = 'n',
        lhs = 'u',
        map = 'undo',
        opts = {}
      },
      redo = {
        hlgroup = 'HighlightRedo',
        mode = 'n',
        lhs = '<C-r>',
        map = 'redo',
        opts = {}
      },
    }
  },
  {
    "aileot/emission.nvim",
    enabled = false,
    event = "VeryLazy",
    config = function()
      require("emission").setup({
        attach = {
          delay = 150,
          excluded_buftypes = {
            "help",
            "nofile",
            "terminal",
            "prompt"
          },
          excluded_filetypes = {
          },
        },
        highlight = {
          duration = 200,
          min_byte = 2,
          filter = function(buf)
            return true
          end,
          additional_recache_events = { "InsertLeave" },
        },
        added = {
          priority = 102,
          hl_map = {
            default = true,
            bold = true,
            fg = "#99c794",
            bg = "#3C465A",
          },
        },
        removed = {
          priority = 101,
          hl_map = {
            default = true,
            bold = true,
            fg = "#D57780",
            bg = "#3C465A",
          },
        },
      })
    end
  },
  {
    "code-biscuits/nvim-biscuits",
    enabled = true,
    event = { 'VeryLazy' },
    config = function()
      require('nvim-biscuits').setup({
        cursor_line_only = true,
        prefix_string = " 📎 ",
        min_distance = 5,
      })
    end,
  },
  {
    "lewis6991/satellite.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = {},
  },
  {
    "j-hui/fidget.nvim",
    enabled = true,
    event = "VeryLazy",
    config = function()
      require("fidget").setup({
        progress = {
          display = {
            progress_icon = { "moon" },
          },
        },
        notification = {
          view = {
            icon_separator = " ",
            group_separator = "────",
          },
          window = {
            border    = "none",
            x_padding = 3,
            y_padding = 1,
          },
        },
      })
      vim.notify = require("fidget").notify
    end
  },
  {
    'SuperBo/fugit2.nvim',
    enabled = false,
    opts = {
        rocks = {
            enabled = false,
        }
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
      'nvim-lua/plenary.nvim',
      {
        'chrisgrieser/nvim-tinygit', -- optional: for Github PR view
        dependencies = { 'stevearc/dressing.nvim' }
      },
      'sindrets/diffview.nvim' -- optional: for Diffview
    },
    cmd = { 'Fugit2', 'Fugit2Graph' },
    keys = {
      { '<leader>F', mode = 'n', '<cmd>Fugit2<cr>' }
    }
  },
  {
    "shellRaining/hlchunk.nvim",
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        chunk = {
            enabled = true,
        }
    },
  },
  -- floating window title
  {
    "b0o/incline.nvim",
    event   = "BufReadPre",
    enabled = true,
    config  = function()
      local function get_diagnostic_label(props)
        local icons = { error = '', warn = '', info = '', hint = '󰌶', }
        local label = {}

        for severity, icon in pairs(icons) do
          local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
          if n > 0 then
            table.insert(label, { icon .. ' ' .. n .. ' ', group = 'DiagnosticSign' .. severity })
          end
        end
        if #label > 0 then
          table.insert(label, {'| '})
        end
        return label
      end

      require("incline").setup({
        window = { margin = { vertical = 0, horizontal = 3 } },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          local modified = vim.api.nvim_buf_get_option(props.buf, "modified") and "bold,italic" or "bold"
          return {
            { get_diagnostic_label(props) },
            { icon, guifg = color }, { " " },
            { filename, gui = modified },
          }
        end,
      })
    end,
  },
  {
    'vanaigr/mark-signs.nvim',
    enabled = true,
    event = "VeryLazy",
    config = function()
      -- vim.opt.signcolumn = 'yes:1' -- recommended

      local ms = require('mark-signs')

      -- hidden, priority, sign_hl, number_hl, line_hl, cursorline_hl
      -- ms.mark_number_options ({ hidden = true })
      ms.mark_builtin_options({ hidden = true })
      -- ms.mark_builtin_options({ priority = 10, sign_hl = 'Comment' })
      ms.mark_lower_options  ({ priority = 11, sign_hl = 'Normal', number_hl = 'CursorLineNr' })
      ms.mark_upper_options  ({ priority = 12, sign_hl = 'Normal', number_hl = 'CursorLineNr' })
      ms.mark_options('.', { hidden = true })
      ms.mark_options('"', { hidden = true })

      local function update()
        -- don't display marks in cmdwin
        if vim.fn.getcmdwintype() ~= '' then return end

        ms.update_marks()
      end

      if MarkSignsTimer then MarkSignsTimer:stop() end
      local timer = vim.uv.new_timer()
      MarkSignsTimer = timer

      timer:start(0, 500, vim.schedule_wrap(function()
        local ok, msg = pcall(update)
        if not ok then
          timer:stop()
          vim.notify(
          'Could not update signs: '..vim.inspect(msg),
          vim.log.levels.ERROR, {}
          )
        end
      end))

      -- update signs instantly when adding marks
      vim.keymap.set('n', 'm', function()
        local char = vim.fn.getcharstr()
        vim.defer_fn(update, 0)
        return 'm'..char
      end, { expr = true })
    end
  },
  {
    'brenoprata10/nvim-highlight-colors',
    enabled = true,
    event = "VeryLazy",
    config = function()
      require("nvim-highlight-colors").setup {
        ---Render style
        ---@usage 'background'|'foreground'|'virtual'
        render = 'background',

        ---Set virtual symbol (requires render to be set to 'virtual')
        virtual_symbol = '■',
        virtual_symbol_position = 'inline',
        enable_named_colors = true,
        enable_tailwind = false,
        custom_colors = {
        }
      }
    end
  },
  {
    "hedyhli/outline.nvim",
    enabled = true,
    cmd= { 'Outline' },
    config = function()
      vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>",
      { desc = "Toggle Outline" })

      require("outline").setup({})
    end,
  },
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {},
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  {
    'felpafel/inlay-hint.nvim',
    event = 'LspAttach',
    -- config = true,
    setup = function()
      require('inlay-hint').setup({
        virt_text_pos = 'inline',
        highlight_group = 'LspInlayHint',
        hl_mode = 'combine',
        display_callback = function(line_hints, options, bufnr)
          if options.virt_text_pos == 'inline' then
            local lhint = {}
            for _, hint in pairs(line_hints) do
              local text = ''
              local label = hint.label
              if type(label) == 'string' then
                text = label
              else
                for _, part in ipairs(label) do
                  text = text .. part.value
                end
              end
              if hint.paddingLeft then
                text = ' ' .. text
              end
              if hint.paddingRight then
                text = text .. ' '
              end
              lhint[#lhint + 1] = { text = text, col = hint.position.character }
            end
            return lhint
          elseif options.virt_text_pos == 'eol' or options.virt_text_pos == 'right_align' then
            local k1 = {}
            local k2 = {}
            table.sort(line_hints, function(a, b)
              return a.position.character < b.position.character
            end)
            for _, hint in pairs(line_hints) do
              local label = hint.label
              local kind = hint.kind
              local node = kind == 1
              and vim.treesitter.get_node({
                bufnr = bufnr,
                pos = {
                  hint.position.line,
                  hint.position.character - 1,
                },
              })
              or nil
              local node_text = node and vim.treesitter.get_node_text(node, bufnr, {}) or ''
              local text = ''
              if type(label) == 'string' then
                text = label
              else
                for _, part in ipairs(label) do
                  text = text .. part.value
                end
              end
              if kind == 1 then
                k1[#k1 + 1] = text:gsub(':%s*', node_text .. ': ')
              else
                k2[#k2 + 1] = text:gsub(':$', '')
              end
            end
            local text = ''
            if #k2 > 0 then
              text = '<- (' .. table.concat(k2, ',') .. ')'
            end
            if #text > 0 then
              text = text .. ' '
            end
            if #k1 > 0 then
              text = text .. '=> ' .. table.concat(k1, ', ')
            end

            return text
          end
          return nil
        end,
      })
    end
  },
  {
    "mawkler/demicolon.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = {},
  },
  {
    "OXY2DEV/bars-N-lines.nvim",
    enabled = false,
    lazy = false,
    config = function()
      require('bars').setup({
        exclude_filetypes = {},
        exclude_buftypes  = {},
        statuscolumn      = false,
        statusline        = true,
        tabline           = false,

      })
    end
  },
  {
    "nvzone/showkeys",
    enabled = true,
    event   = "VeryLazy",
    cmd     = "ShowkeysToggle",
    init    = function()
        require("showkeys").open() -- Enable on startup
    end,
    opts = {
      -- timeout    = 1,
      maxkeys    = 5,
      -- show_count = true,
      -- excluded_modes = { 'i', 'c' },
      position   = "top-right",
      winopts    = {
        focusable = false,
        relative  = "editor",
        style     = "minimal",
        border    = "rounded",
        height    = 1,
        row       = 3,
        col       = 0,
      },
    },
  },
  {
    "sphamba/smear-cursor.nvim",
    enabled= true,
    event = "VeryLazy",
    opts = {
      cursor_color        = "#e0e0e0",
      normal_bg           = "#28303a",
      cterm_cursor_colors = { 231, 233, 235, 237 },
      cterm_bg            = 235,
      stiffness           = 0.6,
      trailing_stiffness  = 0.3,
      trailing_exponent   = 3,
      hide_target_hack    = false,
      never_draw_over_target = true,
      gamma               = 1,
      color_levels        = 256,
      volume_reduction_component = -0.3;
      legacy_computing_symbols_support = true,
    },
  },
  {
    "xzbdmw/colorful-menu.nvim",
    enabled = true,
    event = { "LspAttach" },
    config = function()
      -- You don't need to set these options.
      require("colorful-menu").setup({
        ls = {
          lua_ls = {
            -- Maybe you want to dim arguments a bit.
            arguments_hl = "@comment",
          },
          gopls = {
            -- When true, label for field and variable will format like "foo: Foo"
            -- instead of go's original syntax "foo Foo".
            add_colon_before_type = false,
          },
          ["typescript-language-server"] = {
            extra_info_hl = "@comment",
          },
          ["typescript-tools"] = {
            extra_info_hl = "@comment",
          },
          ts_ls = {
            extra_info_hl = "@comment",
          },
          tsserver = {
            extra_info_hl = "@comment",
          },
          vtsls = {
            extra_info_hl = "@comment",
          },
          ["rust-analyzer"] = {
            -- Such as (as Iterator), (use std::io).
            extra_info_hl = "@comment",
          },
          clangd = {
            -- Such as "From <stdio.h>".
            extra_info_hl = "@comment",
          },
          roslyn = {
            extra_info_hl = "@comment",
          },

          -- If true, try to highlight "not supported" languages.
          fallback = true,
        },
        -- If the built-in logic fails to find a suitable highlight group,
        -- this highlight is applied to the label.
        fallback_highlight = "@variable",
        -- If provided, the plugin truncates the final displayed text to
        -- this width (measured in display cells). Any highlights that extend
        -- beyond the truncation point are ignored. Default 60.
        max_width = 60,
      })
    end,
  },
  {
      "rachartier/tiny-glimmer.nvim",
      enabled = true,
      event = "VeryLazy",
      opts = {
          overwrite = {
              search = { enabled = false },
              paste = {
                  enabled = true,
                  paste_mapping = {
                      lhs = "p",
                      rhs = "p",
                  },
                  Paste_mapping = {
                      lhs = "P",
                      rhs = "P",
                  },
              },
              undo = { enabled = true },
              redo = { enabled = true }
          }
      },
  }
}
