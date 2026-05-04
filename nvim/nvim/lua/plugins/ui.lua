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
            y_padding = 3,
          },
        },
      })
      vim.notify = require("fidget").notify
    end
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
        local icons = { error = '', warn = '', info = '', hint = '󰌶', }
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
          local modified = vim.bo[props.buf].modified and "bold,italic" or "bold"
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
      local ms = require('mark-signs')

      ms.mark_builtin_options({ hidden = true })
      ms.mark_lower_options  ({ priority = 11, sign_hl = 'Normal', number_hl = 'CursorLineNr' })
      ms.mark_upper_options  ({ priority = 12, sign_hl = 'Normal', number_hl = 'CursorLineNr' })
      ms.mark_options('.', { hidden = true })
      ms.mark_options('"', { hidden = true })

      local function update()
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
        render = 'background',
        virtual_symbol = '■',
        virtual_symbol_position = 'inline',
        enable_named_colors = true,
        enable_tailwind = false,
        custom_colors = {}
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
    "ratheesh/showkeys",
    enabled = true,
    event   = "VeryLazy",
    cmd     = "ShowkeysToggle",
    opts    = {
      timeout        = 1,
      maxkeys        = 5,
      show_count     = false,
      excluded_modes = { 'i', 'c' },
      position       = "bottom-right",
      winopts        = {
        focusable = false,
        relative  = "editor",
        style     = "minimal",
        border    = "rounded",
        height    = 1,
        row       = 5,
        col       = -1,
      },
    },
    config  = function(_, opts)
      local showkeys = require("showkeys")
      showkeys.setup(opts)

      vim.defer_fn(function()
        showkeys.open()
      end, 120)

    end,
  },
  {
    "sphamba/smear-cursor.nvim",
    enabled= true,
    event = "VeryLazy",
    opts = {
      normal_bg           = "#28303a",
      cterm_cursor_colors = { 231, 233, 235, 237 },
      cterm_bg            = 235,
      stiffness           = 0.6,
      trailing_stiffness  = 0.3,
      trailing_exponent   = 3,
      hide_target_hack    = true,
      never_draw_over_target = true,
      gamma               = 1,
      color_levels        = 256,
      volume_reduction_component = -0.3,
      legacy_computing_symbols_support = true,
      cursor_color = "none",
    },
  },
  {
    "xzbdmw/colorful-menu.nvim",
    enabled = true,
    event = { "LspAttach" },
    config = function()
      require("colorful-menu").setup({
        ls = {
          lua_ls = {
            arguments_hl = "@comment",
          },
          gopls = {
            add_colon_before_type = false,
          },
          ["typescript-language-server"] = {
            extra_info_hl = "@comment",
          },
          ["rust-analyzer"] = {
            extra_info_hl = "@comment",
          },
          clangd = {
            extra_info_hl = "@comment",
          },
          fallback = true,
        },
        fallback_highlight = "@variable",
        max_width = 60,
      })
    end,
  },
  {
      "rachartier/tiny-glimmer.nvim",
      enabled = false,
      event = "VeryLazy",
      opts = {
          auto_map = true,
          overwrite = {
              search = { enabled = false },
              paste = {
                  enabled = true,
                  paste_mapping = { lhs = "p", rhs = "p" },
                  Paste_mapping = { lhs = "P", rhs = "P" },
              },
              undo = { enabled = true },
              redo = { enabled = true },
          },
          yank = {
            enabled = true,
            default_animation = "fade",
          },
          paste = {
            enabled = true,
            default_animation = "reverse_fade",
            paste_mapping = "p",
            Paste_mapping = "P",
          },
      },
  }
}
