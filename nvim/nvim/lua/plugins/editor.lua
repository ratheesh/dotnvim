return {
  {
    "tpope/vim-sleuth",
    enabled = true,
    event = "VeryLazy"
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")

      npairs.setup({
        check_ts = true,
        ts_config = {
          lua = { "string" },
          javascript = { "template_string" },
          java = false,
        },
      })

      local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }

      npairs.add_rules({
        Rule(" ", " ")
          :with_pair(function(opts)
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return vim.tbl_contains({
              brackets[1][1] .. brackets[1][2],
              brackets[2][1] .. brackets[2][2],
              brackets[3][1] .. brackets[3][2],
            }, pair)
          end)
          :with_move(cond.none())
          :with_cr(cond.none())
          :with_del(function(opts)
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local context = opts.line:sub(col - 1, col + 2)
            return vim.tbl_contains({
              brackets[1][1] .. "  " .. brackets[1][2],
              brackets[2][1] .. "  " .. brackets[2][2],
              brackets[3][1] .. "  " .. brackets[3][2],
            }, context)
          end),
      })

      for _, bracket in pairs(brackets) do
        npairs.add_rules({
          Rule(bracket[1] .. " ", " " .. bracket[2])
            :with_pair(cond.none())
            :with_move(function(opts)
              return opts.char == bracket[2]
            end)
            :with_del(cond.none())
            :use_key(bracket[2])
            :replace_map_cr(function(_)
              return "<C-c>2xi<CR><C-c>O"
            end),
        })
      end
    end,
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
  {
    'nemanjamalesija/smart-paste.nvim',
    enabled = true,
    keys = { 'p', 'P', 'gp', 'gP' },
    event = 'VeryLazy',
    config = true,
  },
}
