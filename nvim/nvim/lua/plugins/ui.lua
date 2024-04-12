return {
  {
    "lukas-reineke/virt-column.nvim",
    enabled = true,
    event   = 'VeryLazy',
    config = function ()
      require("virt-column").setup({char = '▕', virtcolumn = '+1'})
    end
  },
  {
    'tzachar/highlight-undo.nvim',
    enabled = true,
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
    "code-biscuits/nvim-biscuits",
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
    event = "VeryLazy",
    config = function()
      require('satellite').setup({})
    end
  },
  {
    "j-hui/fidget.nvim",
    enabled = false,
    config=function()
      require('fidget').setup({
        -- Options related to LSP progress subsystem
        progress = {
          poll_rate = 0,                -- How and when to poll for progress messages
          suppress_on_insert = false,   -- Suppress new messages while in insert mode
          ignore_done_already = false,  -- Ignore new tasks that are already complete
          ignore_empty_message = false, -- Ignore new tasks that don't contain a message
          clear_on_detach =             -- Clear notification group when LSP server detaches
          function(client_id)
            local client = vim.lsp.get_client_by_id(client_id)
            return client and client.name or nil
          end,
          notification_group =          -- How to get a progress message's notification group key
          function(msg) return msg.lsp_client.name end,
          ignore = {},                  -- List of LSP servers to ignore

          -- Options related to how LSP progress messages are displayed as notifications
          display = {
            render_limit = 16,          -- How many LSP messages to show at once
            done_ttl = 3,               -- How long a message should persist after completion
            done_icon = "✔",            -- Icon shown when all LSP progress tasks are complete
            done_style = "Constant",    -- Highlight group for completed LSP tasks
            progress_ttl = math.huge,   -- How long a message should persist when in progress
            progress_icon =             -- Icon shown when LSP progress tasks are in progress
            { pattern = "dots", period = 1 },
            progress_style =            -- Highlight group for in-progress LSP tasks
            "WarningMsg",
            group_style = "Title",      -- Highlight group for group name (LSP server name)
            icon_style = "Question",    -- Highlight group for group icons
            priority = 30,              -- Ordering priority for LSP notification group
            skip_history = true,        -- Whether progress notifications should be omitted from history
            format_message =            -- How to format a progress message
            require("fidget.progress.display").default_format_message,
            format_annote =             -- How to format a progress annotation
            function(msg) return msg.title end,
            format_group_name =         -- How to format a progress notification group's name
            function(group) return tostring(group) end,
            overrides = {               -- Override options from the default notification config
              rust_analyzer = { name = "rust-analyzer" },
            },
          },

          -- Options related to Neovim's built-in LSP client
          lsp = {
            progress_ringbuf_size = 0,  -- Configure the nvim's LSP progress ring buffer size
          },
        },

        -- Options related to notification subsystem
        notification = {
          poll_rate = 10,               -- How frequently to update and render notifications
          filter = vim.log.levels.INFO, -- Minimum notifications level
          history_size = 128,           -- Number of removed messages to retain in history
          override_vim_notify = false,  -- Automatically override vim.notify() with Fidget
          configs =                     -- How to configure notification groups when instantiated
          { default = require("fidget.notification").default_config },
          redirect =                    -- Conditionally redirect notifications to another backend
          function(msg, level, opts)
            if opts and opts.on_open then
              return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
            end
          end,

          -- Options related to how notifications are rendered as text
          view = {
            stack_upwards = true,       -- Display notification items from bottom to top
            icon_separator = " ",       -- Separator between group name and icon
            group_separator = "---",    -- Separator between notification groups
            group_separator_hl =        -- Highlight group used for group separator
            "Comment",
            render_message =            -- How to render notification messages
            function(msg, cnt)
              return cnt == 1 and msg or string.format("(%dx) %s", cnt, msg)
            end,
          },

          -- Options related to the notification window and buffer
          window = {
            normal_hl = "Comment",      -- Base highlight group in the notification window
            winblend = 100,             -- Background color opacity in the notification window
            border = "none",            -- Border around the notification window
            zindex = 45,                -- Stacking priority of the notification window
            max_width = 0,              -- Maximum width of the notification window
            max_height = 0,             -- Maximum height of the notification window
            x_padding = 1,              -- Padding from right edge of window boundary
            y_padding = 0,              -- Padding from bottom edge of window boundary
            align = "bottom",           -- How to align the notification window
            relative = "editor",        -- What the notification window position is relative to
          },
        },

        -- Options related to integrating with other plugins
        integration = {
          ["nvim-tree"] = {
            enable = true,              -- Integrate with nvim-tree/nvim-tree.lua (if installed)
          },
        },

        -- Options related to logging
        logger = {
          level = vim.log.levels.WARN,  -- Minimum logging level
          float_precision = 0.01,       -- Limit the number of decimals displayed for floats
          path =                        -- Where Fidget writes its logs to
          string.format("%s/fidget.nvim.log", vim.fn.stdpath("cache")),
        },
      })
    end,
  },
  {
    'SuperBo/fugit2.nvim',
    opts = {},
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
    enabled=false,
    event = { "UIEnter" },
    config = function()
      require("hlchunk").setup({
        chunk={
          style = "#40586c",
        },
        indent = {
          enable = false,
        },
        blank = {
          enable = false,
        },
        line_num = {
          enable = false;
        },
      })
    end
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

}
