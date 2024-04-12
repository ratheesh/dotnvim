return {
  {
    "lukas-reineke/virt-column.nvim",
    enabled = true,
    event   = 'VeryLazy',
    config = function ()
      require("virt-column").setup({
        char = '│',
        virtcolumn = '+1',
        highlight = "VirtColumn",
    }) --▕
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
    enabled = true,
    event = "VeryLazy",
    config = function()
      require("fidget").setup({})
    end
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
