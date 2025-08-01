return {
  {
    "tpope/vim-sleuth",
    enabled = true,
    event = "VeryLazy"
  },
  {
    'altermo/ultimate-autopair.nvim',
    enabled=false,
    branch = "v0.6",
    event={'InsertEnter', 'CmdlineEnter'},
    config=function ()
      require('ultimate-autopair').setup({
        --Config goes here
      })
    end
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
    opts = {},
  },
  {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    keys = { n = { 'ds', 'cs' }, x = { 'S' } },
    config = function ()
      require('nvim-surround').setup()
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    config = function()
      require("treesitter-context").setup({
          enable       = true,
          max_lines    = 1,
          multiline_threshold = 2;
          line_numbers = true,
          mode         = 'topline',
          separator    = '─',
      })
    end,
  },
  {
      "mbbill/undotree",
      enabled = false,
      cmd = { "UndotreeShow", "UndotreeToggle", "UndotreeHide", "UndotreeFocus" },
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
    'ibhagwan/smartyank.nvim',
    enabled = true,
    event = "VeryLazy",
    keys = { 'y', 'Y', 'd', 'D', 'x' },
    config = function()
      require('smartyank').setup ({
        highlight = {
          enabled = true,
          higroup = "IncSearch",
          timeout = 200,
        },
      })
    end
  },
  {
    "nvimdev/hlsearch.nvim",
    enabled = true,
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
          "// %s", -- default commentstring when no treesitter node matches
          "/* %s */",
          call_expression = "// %s", -- specific commentstring for call_expression
          jsx_attribute = "// %s",
          jsx_element = "{/* %s */}",
          jsx_fragment = "{/* %s */}",
          spread_element = "// %s",
          statement_block = "// %s",
        },
        lua = { "-- %s", "--- %s" }, -- langs can have multiple commentstrings
        typescript = "// %s",
        vim = '" %s',
        vue = "<!-- %s -->",
        xml = "<!-- %s -->",
      },
    }
  },
  {
      'ojroques/nvim-osc52',
      enabled = true,
      event = "VeryLazy",
      init = function()
          local copy = function()
              if vim.v.event.operator == 'y' and vim.v.event.regname == '+' then
                  require('osc52').copy_register('+')
              end
          end

          vim.api.nvim_create_autocmd('TextYankPost', {callback = copy})
      end
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
    "Goose97/timber.nvim",
    enabled = false,
    event = "VeryLazy",
    config = function()
      local opts = {
        log_templates = {
          default = {
            c = [[printf("%s:%s():%d:===== %%log_target =====\n", __FILE__, __func__, __LINE__, %log_target);]],
          },
        },
      }

      require("timber").setup(opts)
    end
  },
  {
    "aidancz/lfsp.nvim",
    enabled = true,
    event   = "VeryLazy",
    config = function()
      vim.keymap.set(
        {"n", "x", "o"},
        "<CR>",
        function()
          return
          require("lf").expr({
            direction = "next",
            follow = false,
          })
        end,
        {expr = true}
      )
      vim.keymap.set(
        {"n", "x", "o"},
        "<M>",
        function()
          return
          require("lf").expr({
            direction = "prev",
            follow = false,
          })
        end,
        {expr = true}
      )
      vim.keymap.set(
        {"n", "x", "o"},
        "<left>",
        function()
          return
          require("sp").expr({
            direction = "prev",
            follow = false,
          })
        end,
        {expr = true}
      )
      vim.keymap.set(
        {"n", "x", "o"},
        "<right>",
        function()
          return
          require("sp").expr({
            direction = "next",
            follow = false,
          })
        end,
        {expr = true}
      )
    end
  },
  {
      "bassamsdata/namu.nvim",
      enabled = true,
      event = "VeryLazy",
      config = function()
          require("namu").setup({
              namu_symbols = {
                  enable = true,
                  options = {}, -- here you can configure namu
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
}
