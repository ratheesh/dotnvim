return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    dependencies = {
      "RRethy/nvim-treesitter-endwise",
    },
    opts = {
        highlight        = { enable = true  },
        indent           = { enable = true  },
        matchup          = { enable = true  },
        autopairs        = { enable = true  },
        autotag          = { enable = false },
        endwise          = { enable = true  },
        swap = {
          enable = false,
          swap_next = {
            ["ap"] = "@parameter.inner",
          },
          swap_previous = {
            -- ["an"] = "@parameter.inner",
          },
        },
        ensure_installed = {
          "bash",
          "c",
          "cpp",
          "cmake",
          "comment",
          "diff",
          "dockerfile",
          "git_config",
          "git_rebase",
          "gitcommit",
          "gitignore",
          "javascript",
          "json",
          "lua",
          "markdown",
          "python",
          "regex",
          "rust",
          "tmux",
          "toml",
          "vim",
          "xml",
          "yaml",
          "zsh",
        },
    },
    config = function(_, opts)
      require('nvim-treesitter.config').setup (opts)

      local ignore_filetype = {
        "checkhealth",
        "lazy",
        "mason",
        "snacks_dashboard",
        "snacks_notif",
        "snacks_win",
        "snacks_input",
        "snacks_picker_input",
        "TelescopePrompt",
        "alpha",
        "dashboard",
        "spectre_panel",
        "NvimTree",
        "undotree",
        "Outline",
        "sagaoutline",
        "copilot-chat",
        "vscode-diff-explorer",
      }

      local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        desc = "Enable TreeSitter highlighting and indentation",
        callback = function(ev)
          local ft = ev.match

          if vim.tbl_contains(ignore_filetype, ft) then
            return
          end

          local lang = vim.treesitter.language.get_lang(ft) or ft
          local buf = ev.buf
          pcall(vim.treesitter.start, buf, lang)

          vim.wo.foldexpr   = "v:lua.vim.treesitter.foldexpr()"
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    opts = {},
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          enable    = true,
          lookahead = true,
          include_surrounding_whitespace = false,
        },
        move = {
          set_jumps = true,
        },
      })

      local ts_move = require("nvim-treesitter-textobjects.move")
      local ts_select = require("nvim-treesitter-textobjects.select")

      ---- MOVE ---------------------------------------------------------------
      --------- got_next_start
      vim.keymap.set({ "n", "x", "o" }, "]f", function()
        ts_move.goto_next_start("@function.outer", "textobjects")
      end, { desc = "Next function start", silent = true })
      vim.keymap.set({ "n", "x", "o" }, "]c", function()
        ts_move.goto_next_start("@class.outer", "textobjects")
      end, { desc = "Next class start", silent = true })
      vim.keymap.set({ "n", "x", "o" }, "]w", function()
        ts_move.goto_next_start("@block.outer", "textobjects")
      end, { desc = "Next block start", silent = true })
      vim.keymap.set({ "n", "x", "o" }, "]k", function()
        ts_move.goto_next_start("@comment.outer", "textobjects")
      end, { desc = "Next comment", silent = true })

      --------- goto_next_end
      vim.keymap.set({ "n", "x", "o" }, "]F", function()
        ts_move.goto_next_end("@function.outer", "textobjects")
      end, { desc = "Next function end", silent = true })
      vim.keymap.set({ "n", "x", "o" }, "]C", function()
        ts_move.goto_next_end("@class.outer", "textobjects")
      end, { desc = "Next class end", silent = true })
      -- vim.keymap.set({ "n", "x", "o" }, "]A", function()
      --   ts_move.goto_next_end("@parameter.inner", "textobjects")
      -- end, { desc = "Next parameter end", silent = true })

      --------- goto_previous_start
      vim.keymap.set({ "n", "x", "o" }, "[f", function()
        ts_move.goto_previous_start("@function.outer", "textobjects")
      end, { desc = "Previous function start", silent = true })
      vim.keymap.set({ "n", "x", "o" }, "[c", function()
        ts_move.goto_previous_start("@class.outer", "textobjects")
      end, { desc = "Previous class start", silent = true })
      vim.keymap.set({ "n", "x", "o" }, "[w", function()
        ts_move.goto_previous_start("@block.outer", "textobjects")
      end, { desc = "Previous block start", silent = true })
      vim.keymap.set({ "n", "x", "o" }, "[k", function()
        ts_move.goto_previous_start("@comment.outer", "textobjects")
      end, { desc = "Previous comment", silent = true })

      --------- goto_previous_end
      vim.keymap.set({ "n", "x", "o" }, "[F", function()
        ts_move.goto_previous_end("@function.outer", "textobjects")
      end, { desc = "Previous function end", silent = true })
      vim.keymap.set({ "n", "x", "o" }, "[C", function()
        ts_move.goto_previous_end("@class.outer", "textobjects")
      end, { desc = "Previous class end", silent = true })

      vim.keymap.set({ "n", "x", "o" }, "]d", function()
        ts_move.goto_next("@conditional.outer", "textobjects")
      end, { desc = "Next conditional", silent = true })
      vim.keymap.set({ "n", "x", "o" }, "[d", function()
        ts_move.goto_previous("@conditional.outer", "textobjects")
      end, { desc = "Previous conditional", silent = true })

      ---- SELECT -------------------------------------------------------------
      vim.keymap.set({ "x", "o" }, "af", function()
        ts_select.select_textobject("@function.outer", "textobjects")
      end, { desc = "Select around function", silent = true })
      vim.keymap.set({ "x", "o" }, "if", function()
        ts_select.select_textobject("@function.inner", "textobjects")
      end, { desc = "Select inside function", silent = true })
      vim.keymap.set({ "x", "o" }, "aC", function()
        ts_select.select_textobject("@class.outer", "textobjects")
      end, { desc = "Select around class", silent = true })
      vim.keymap.set({ "x", "o" }, "iC", function()
        ts_select.select_textobject("@class.inner", "textobjects")
      end, { desc = "Select inside class", silent = true })
      vim.keymap.set({ "x", "o" }, "ac", function()
        ts_select.select_textobject("@conditional.outer", "textobjects")
      end, { desc = "Select around conditional", silent = true })
      vim.keymap.set({ "x", "o" }, "ic", function()
        ts_select.select_textobject("@conditional.inner", "textobjects")
      end, { desc = "Select inside conditional", silent = true })
      vim.keymap.set({ "x", "o" }, "al", function()
        ts_select.select_textobject("@loop.outer", "textobjects")
      end, { desc = "Select around loop", silent = true })
      vim.keymap.set({ "x", "o" }, "il", function()
        ts_select.select_textobject("@loop.inner", "textobjects")
      end, { desc = "Select inside loop", silent = true })
      vim.keymap.set({ "x", "o" }, "ak", function()
        ts_select.select_textobject("@comment.outer", "textobjects")
      end, { desc = "Select around comment", silent = true })
      vim.keymap.set({ "x", "o" }, "as", function()
        ts_select.select_textobject("@statement.outer", "textobjects")
      end, { desc = "Select around statement", silent = true })
      vim.keymap.set({ "x", "o" }, "ab", function()
        ts_select.select_textobject("@block.outer", "textobjects")
      end, { desc = "Select around block", silent = true })
      vim.keymap.set({ "x", "o" }, "ib", function()
        ts_select.select_textobject("@block.inner", "textobjects")
      end, { desc = "Select inside block", silent = true })

      vim.keymap.set({ "x", "o" }, "aa", function()
        ts_select.select_textobject("@parameter.outer", "textobjects")
      end, { desc = "Select outside parameter", silent = true })

      vim.keymap.set({ "x", "o" }, "ia", function()
        ts_select.select_textobject("@parameter.inner", "textobjects")
      end, { desc = "Select inside parameter", silent = true })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {
      max_lines = 0,
      multiline_threshold = 2,
      enable       = true,
      line_numbers = true,
      mode         = 'topline',
      separator    = '─',
    },
  },
  {
    {
      "Wansmer/treesj",
      keys = {
        { "<leader>mS", "", desc = "TreeSJ" },
        { "<leader>mSt", "<CMD>TSJToggle<CR>", desc = "Toggle" },
        { "<leader>mSj", "<CMD>TSJJoin<CR>", desc = "Join" },
        { "<leader>mSs", "<CMD>TSJSplit<CR>", desc = "Split" },
      },
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      opts = {
        use_default_keymaps = false,
      },
      config = true,
    },
  },
  {
    'HiPhish/rainbow-delimiters.nvim',
    enabled = true,
    event = "VeryLazy",
    submodules = false,
    config = function()
      local rainbow_delimiters = require('rainbow-delimiters')
      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        highlight = {
          'rainbowcol1',
          'rainbowcol2',
          'rainbowcol3',
          'rainbowcol4',
          'rainbowcol5',
          'rainbowcol6',
          'rainbowcol7',
        },
      }
    end
  },
  {
    "mawkler/demicolon.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = {},
  },
}

