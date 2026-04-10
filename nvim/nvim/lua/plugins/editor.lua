return {
  {
    "tpope/vim-sleuth",
    enabled = true,
    event = "VeryLazy"
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
    opts = {},
  },
  -- Endwise via built-in treesitter (replaces nvim-treesitter-endwise)
  {
    "brianhuster/treesitter-endwise.nvim",
    event = "InsertEnter",
  },
  {
    "XXiaoA/atone.nvim",
    enabled = true,
    cmd = "Atone",
    opts = {},
  },
  {
      "ruskei/undotree",
      enabled = true,
      dependencies = "nvim-lua/plenary.nvim",
      config = true,
      keys = {
          { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
      },
  },
  {
    'winston0410/range-highlight.nvim',
    enabled = true,
    event =  "VeryLazy",
    dependencies = {
      'winston0410/cmd-parser.nvim'
    },
    config = function()
      require('range-highlight').setup({})
    end
  },
  {
    "nvimdev/hlsearch.nvim",
    enabled = false,
    event = "VeryLazy",
    config = function()
      require("hlsearch").setup()
    end
  },
  {
    'coderifous/textobj-word-column.vim',
    event = "VeryLazy",
  },
  {
    "folke/ts-comments.nvim",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
    event = "VeryLazy",
    opts = {
      lang = {
        c = "/* %s */",
        cpp = "// %s",
        css = "/* %s */",
        html = "<!-- %s -->",
        ini = "; %s",
        javascript = {
          "// %s",
          "/* %s */",
          call_expression = "// %s",
          jsx_attribute = "// %s",
          jsx_element = "{/* %s */}",
          jsx_fragment = "{/* %s */}",
          spread_element = "// %s",
          statement_block = "// %s",
        },
        lua = { "-- %s", "--- %s" },
        typescript = "// %s",
        vim = '" %s',
        vue = "<!-- %s -->",
        xml = "<!-- %s -->",
      },
    }
  },
  {
    {
      "atiladefreitas/lazyclip",
      config = function()
        require("lazyclip").setup()
      end,
      keys = {
        { "<leader>y", ":lua require('lazyclip').show_clipboard()<CR>", desc = "Open Clipboard Manager" },
      },
    },
  },
  {
    "aidancz/lfsp.nvim",
    enabled = false,
  },
  {
      "bassamsdata/namu.nvim",
      enabled = true,
      event = "VeryLazy",
      config = function()
          require("namu").setup({
              namu_symbols = {
                  enable = true,
                  options = {},
              },
              colorscheme = {
                  enable = false,
                  options = {
                      persist = true,
                      write_shada = false,
                  },
              },
              ui_select = { enable = false },
          })
          local namu = require("namu.namu_symbols")
          local colorscheme = require("namu.colorscheme")
          vim.keymap.set("n", "<leader>ss", namu.show, {
              desc = "Jump to LSP symbol",
              silent = true,
          })
          vim.keymap.set("n", "<leader>th", colorscheme.show, {
              desc = "Colorscheme Picker",
              silent = true,
          })
      end,
  },
  {
      'lewis6991/spaceless.nvim',
      enabled = true,
      event   = "VeryLazy",
      opts    = {}
  },
  {
    "leblocks/toggle.nvim",
    keys = { '+', '-' },
    config = function()
      require('toggle').setup({
        defaults = true,
        keep_cursor_position = true,
        mappings = {
          { 'yes', 'no' },
          { 'foo', 'bar', 'baz' },
          { '<<', '>>' },
        },
      })
      vim.keymap.set('n', '-', require('toggle').toggle, { desc = 'Toggle word' })
      vim.keymap.set('n', '+', require('toggle').toggle, { desc = 'Toggle word' })
    end
  },
}
