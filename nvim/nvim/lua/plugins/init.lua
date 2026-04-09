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
    enabled = false,
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
          require('hover.providers.lsp')
          require('hover.providers.man')
          require('hover.providers.gh')
          require('hover.providers.dictionary')
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
      'echasnovski/mini.align',
      enabled = true,
      version = false,
      event   = { 'VeryLazy' },
      opts    = {},
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
}
-- End of File
