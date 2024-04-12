return {
  { "tpope/vim-repeat", keys = "." },
  {
    'hood/popui.nvim',
    disable = false,
    config = function()
      vim.ui.select = require('popui.ui-overrider')
      vim.ui.input = require('popui.input-overrider')
    end
  },
  { 'psliwka/vim-smoothie', keys = { '<c-u>', '<c-d>' }},
  {
    "lukas-reineke/virt-column.nvim",
    enabled = true,
    event   = 'VeryLazy',
    config = function ()
      require("virt-column").setup({char = '▕', virtcolumn = '+1'})
    end
  },
  {
    'NvChad/nvim-colorizer.lua',
    enabled=true,
    event = 'VimEnter',
    config = function ()
      require('colorizer').setup({
        filetypes = { "*" },
        user_default_options = {
          names = false,
          tailwind = "both",
          mode = "background"
        }
      })
    end,
  },
  {
    "mbbill/undotree",
    cmd = { "UndotreeShow", "UndotreeToggle", "UndotreeHide", "UndotreeFocus" },
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
    'echasnovski/mini.indentscope',
    event = 'LspAttach',
    config = function()
      require('mini.indentscope').setup({
        symbol = '╎',
      })
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    enabled = true,
    cmd = "SymbolsOutline",
    init = function()
      vim.keymap.set("n", "<leader>cs", "<cmd>SymbolsOutline<cr>", { desc = "Symbols Outline" })
    end,
    config = function()
      require("symbols-outline").setup()
    end,
  },
  {
    "cshuaimin/ssr.nvim",
    enabled = true,
    keys = { '<space>cR' },
    init = function()
      vim.keymap.set({ "n", "x" }, "<leader>cR", function()
        require("ssr").open()
      end, { desc = "Structural Replace" })
    end,
  },
  {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    keys = { n = { 'ds', 'cs' }, x = { 'S' } },
    config = function ()
      require('nvim-surround').setup({
        highlight = {
          duration = 300,
        }
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    config = function()
      require("treesitter-context").setup()
    end,
  },
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  {
    'lewis6991/hover.nvim',
    enabled = true,
    event = 'LspAttach',
    require = 'nvim-lspconfig',
    config = function()
      require('hover').setup {
        init = function()
          -- Require providers
          require('hover.providers.lsp')
          require('hover.providers.man')
          require('hover.providers.gh')
          require('hover.providers.dictionary')
          -- require('hover.providers.LspAttach')
          -- require('hover.providers.css')
        end,
        preview_opts = {
          border = 'rounded',
        },
        title = true
      }
      vim.keymap.set('n', 'K', require('hover').hover, { desc = 'hover.nvim' })
      vim.keymap.set("n", "gK", require("hover").hover_select, {desc = "hover.nvim (select)"})
      vim.keymap.set("n", "<C-p>", function() require("hover").hover_switch("previous") end, {desc = "hover.nvim (previous source)"})
      vim.keymap.set("n", "<C-n>", function() require("hover").hover_switch("next") end, {desc = "hover.nvim (next source)"})
    end
  },
  {
    'junegunn/vim-easy-align',
    enabled = true,
    event   = "VeryLazy",
    config  = function ()
      vim.cmd([[
      xmap ga <Plug>(EasyAlign)
      nmap ga <Plug>(EasyAlign)
      ]])
    end
  },
  {
    'dhruvasagar/vim-table-mode',
    cmd = { 'TableModeToggle' , 'TableModeEnable', 'TableModeDisable', 'TableModeRealign' },
    config = function ()
      vim.g.table_mode_corner_corner   = '+'
      vim.g.table_mode_header_fillchar = '='
      vim.b.table_mode_corner          = '+'
    end
  },
  {
    'antoyo/vim-licenses',
    cmd = { 'Gplv2', 'Apache', 'Mit' },
    config = function ()
      vim.g.licenses_copyright_holders_name = 'Ratheesh <ratheeshreddy@gmail.com>'
      vim.g.licenses_authors_name           = 'Ratheesh S'
      vim.g.licenses_default_commands       = { 'Gplv2', 'Apache', 'Mit' }
    end
  },
  {
    'IMOKURI/line-number-interval.nvim',
    enabled = false,
    event = 'BufReadPost',
    config = function()
      vim.g.line_number_interval_enable_at_startup=1
      vim.g.line_number_interval=5
      vim.cmd([[LineNumberIntervalEnable]])
    end
  }
}
-- End of File
