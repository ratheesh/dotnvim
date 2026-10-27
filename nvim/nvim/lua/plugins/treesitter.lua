-- Copyright (c) 2026 Ratheesh<ratheeshreddy@gmail.com>. All Rights Reserved.
-- License: MiT
-- Treesitter plugins

return {
  -- Parser installer only — all highlighting/folding/indentation handled by
  -- Neovim's built-in treesitter (vim.treesitter.*).
  {
    'nvim-treesitter/nvim-treesitter',
    event = { "BufReadPost", "BufNewFile" },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.config').setup({
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
      })

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
        desc = "Enable built-in TreeSitter highlighting and folding",
        callback = function(ev)
          if vim.tbl_contains(ignore_filetype, ev.match) then
            return
          end

          local lang = vim.treesitter.language.get_lang(ev.match) or ev.match
          pcall(vim.treesitter.start, ev.buf, lang)
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
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

      -- { lhs, query, desc }
      local move_keys = {
        goto__next_start = {
          { ["]f"] = "@function.outer", "Next function start" },
          { ["]c"] = "@class.outer",    "Next class start" },
          { ["]w"] = "@block.outer",    "Next block start" },
          { ["]k"] = "@comment.outer",  "Next comment start" },
        },
        goto__next_end = {
          { ["]F"] = "@function.outer", "Next function end" },
          { ["]C"] = "@class.outer",    "Next class end" },
        },
        goto__previous_start = {
          { ["[f"] = "@function.outer", "Previous function start" },
          { ["[c"] = "@class.outer",    "Previous class start" },
          { ["[w"] = "@block.outer",    "Previous block start" },
          { ["[k"] = "@comment.outer",  "Previous comment start" },
        },
        goto__previous_end = {
          { ["[F"] = "@function.outer", "Previous function end" },
          { ["[C"] = "@class.outer",    "Previous class end" },
        },
        goto_next = {
          { ["]d"] = "@conditional.outer", "Next conditional" },
        },
        goto_previous = {
          { ["[d"] = "@conditional.outer", "Previous conditional" },
        },
      }

      local select_keys = {
        { "af", "@function.outer", "select around function" },
        { "if", "@function.inner", "Select inside function" },
        { "aC", "@class.outer", "Select around class" },
        { "iC", "@class.inner", "Select inside class" },
        { "ac", "@conditional.outer", "Select around conditional" },
        { "ic", "@conditional.inner", "Select inside conditional" },
        { "ak", "@comment.outer", "Select around comment" },
        { "as", "@statement.outer", "Select around statement" },
        { "ab", "@block.outer", "Select around block" },
        { "ib", "@block.inner", "Select inside block" },
        { "aa", "@parameter.outer", "Select around parameter" },
        { "ia", "@parameter.inner", "Select inside parameter" },
      }

      for method, keys in pairs(move_keys) do
        for _, k in ipairs(keys) do
          vim.keymap.set({"n", "x", "o"}, k[1], function()
            ts_move[method](k[2], "textobjects")
          end, { desc = k[3], silent = true })
        end
      end

      for _, k in ipairs(select_keys) do
        vim.keymap.set({ "x", "o" }, k[1], function()
          ts_select.select_textobject(k[2], "textobjects")
        end, { desc = k[3], silent = true })
      end
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {
      max_lines           = 1,
      multiline_threshold = 1,
      enable              = true,
      line_numbers        = true,
      mode                = 'topline',
      separator           = '─',
    },
  },
  -- Replaces treesj; uses built-in treesitter queries, no nvim-treesitter dependency
  {
    "echasnovski/mini.splitjoin",
    keys = {
      { "<leader>mS",  "",                                                 desc = "SplitJoin" },
      { "<leader>mSt", function() require("mini.splitjoin").toggle() end,  desc = "Toggle"    },
      { "<leader>mSj", function() require("mini.splitjoin").join()   end,  desc = "Join"      },
      { "<leader>mSs", function() require("mini.splitjoin").split()  end,  desc = "Split"     },
    },
    opts = {
      mappings = { toggle = '' },
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
          ['']  = rainbow_delimiters.strategy['global'],
          vim   = rainbow_delimiters.strategy['local'],
        },
        query = {
          ['']  = 'rainbow-delimiters',
          lua   = 'rainbow-blocks',
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
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    opts = {},
  },
}
