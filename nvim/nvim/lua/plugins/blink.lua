return {
  {
    "saghen/blink.cmp",
    enabled = false,
    version = '1.*',
    event = { "InsertEnter", "CmdlineEnter" },

    dependencies = {
      "rafamadriz/friendly-snippets",
      "L3MON4D3/LuaSnip",
      "onsails/lspkind-nvim",
      "xzbdmw/colorful-menu.nvim",

      {
        "fang2hou/blink-copilot",
        opts = {
          max_completions = 3,
          max_attempts = 2,
        },
      },

      -- wraps nvim-cmp sources for use with blink
      { "saghen/blink.compat", version = "*", opts = {} },

      -- nvim-cmp sources bridged via blink-compat
      "hrsh7th/cmp-emoji",
      "f3fora/cmp-spell",
      "fazibear/cmp-nerdfonts",
      { "davidsierradz/cmp-conventionalcommits", ft = "gitcommit" },
      "dmitmel/cmp-cmdline-history",
    },

    opts = function(_, opts)

      ------------------------------------------------
      -- LUASNIP SETUP (mirrors cmp.lua)
      ------------------------------------------------

      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
      luasnip.config.setup({
        region_check_events = "CursorMoved",
        delete_check_events = "TextChanged",
      })

      ------------------------------------------------
      -- SNIPPET ENGINE
      ------------------------------------------------

      opts.snippets = {
        preset = "luasnip",
      }

      ------------------------------------------------
      -- SOURCES
      ------------------------------------------------

      opts.sources = {

        -- dynamic: big-file guard + per-filetype routing (mirrors cmp.lua)
        default = function()
          local max = 100 * 1024
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(0))
          if ok and stats and stats.size > max then
            return { "lsp", "path" }
          end
          local ft = vim.bo.filetype
          if ft == "gitcommit" then
            return { "conventionalcommits", "lsp", "snippets", "buffer" }
          end
          if ft == "namu_prompt" or ft == "namu_sidebar" then
            return {}
          end
          return { "copilot", "lsp", "snippets", "path", "nerdfonts", "buffer", "emoji", "spell" }
        end,

        providers = {

          copilot = {
            name = "copilot",
            module = "blink-copilot",
            async = true,
            score_offset = 100,
            opts = {
              max_completions = 3,
              max_attempts = 2,
            },
          },

          lsp = {
            name = "lsp",
            module = "blink.cmp.sources.lsp",
            score_offset = 90,
            -- clangd score integration (mirrors cmp.lua's clangd_cmp comparator)
            transform_items = function(_, items)
              for _, item in ipairs(items) do
                local clangd_score = vim.tbl_get(item, "completionItem", "score")
                if type(clangd_score) == "number" then
                  item.score_offset = (item.score_offset or 0) + clangd_score
                end
              end
              return items
            end,
          },

          path = {
            name = "Path",
            module = "blink.cmp.sources.path",
            score_offset = 3,
            opts = {
              trailing_slash = false,
              label_trailing_slash = true,
              show_hidden_files_by_default = true,
              get_cwd = function(ctx)
                return vim.fn.expand(("#%d:p:h"):format(ctx.bufnr))
              end,
            },
          },

          -- Use the default (VSCode-parser) backend instead of the luasnip
          -- backend.  The luasnip backend's resolve() can fail silently
          -- (async promise never resolves) leaving the doc window blank.
          -- The default backend always populates detail + documentation.
          -- Expansion still goes through LuaSnip (opts.snippets.preset).
          snippets = {
            name = "Snippets",
            module = "blink.cmp.sources.snippets.default",
            score_offset = 85,
            opts = { friendly_snippets = true },
          },

          -- only index visible buffers ≤ 1MB (mirrors cmp.lua buffer opts)
          buffer = {
            name = "Buffer",
            module = "blink.cmp.sources.buffer",
            min_keyword_length = 2,
            opts = {
              get_bufnrs = function()
                local bufs = {}
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                  local buf = vim.api.nvim_win_get_buf(win)
                  local size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
                  if size <= 1024 * 1024 then
                    bufs[buf] = true
                  end
                end
                return vim.tbl_keys(bufs)
              end,
            },
          },

          -- blink-compat wrapped sources
          nerdfonts = { name = "nerdfonts", module = "blink.compat.source" },
          emoji     = { name = "emoji",     module = "blink.compat.source" },
          spell     = { name = "spell",     module = "blink.compat.source" },

          conventionalcommits = {
            name   = "conventionalcommits",
            module = "blink.compat.source",
          },

          cmdline_history = {
            name   = "cmdline_history",
            module = "blink.compat.source",
          },
        },
      }

      ------------------------------------------------
      -- MATCHING
      ------------------------------------------------

      opts.fuzzy = {
        implementation = "prefer_rust",
      }

      opts.completion = opts.completion or {}

      opts.completion.keyword = {
        range = "full",
      }

      ------------------------------------------------
      -- APPEARANCE
      ------------------------------------------------

      opts.appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      }

      ------------------------------------------------
      -- MENU UI
      ------------------------------------------------

      local has_colorful, colorful_menu = pcall(require, "colorful-menu")
      local has_lspkind, lspkind = pcall(require, "lspkind")

      local function label_text(ctx)
        local info = (has_colorful and colorful_menu.blink_highlights(ctx)) or nil
        return info and info.label or ctx.label
      end

      local function label_highlight(ctx)
        local highlights = {}
        local info = (has_colorful and colorful_menu.blink_highlights(ctx)) or nil
        if info then highlights = info.highlights end
        for _, idx in ipairs(ctx.label_matched_indices) do
          table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
        end
        return highlights
      end

      opts.completion.menu = {
        border = "single",
        max_height = 12,
        winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpDocBorder,CursorLine:CmpSel,Search:PmenuSel",

        draw = {
          padding = { 0, 1 },
          gap = 1,
          treesitter = { "lsp" },

          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "source_name" },
          },

          components = {

            kind_icon = {
              text = function(ctx)
                local symbols = (has_lspkind and lspkind.symbol_map) or {}
                local icon = symbols[ctx.kind] or ctx.kind_icon or ""
                return " " .. icon .. ""
              end,
              highlight = function(ctx)
                return "BlinkCmpKind" .. ctx.kind
              end,
            },

            label = {
              width = { fill = true, max = 40 },
              text = label_text,
              highlight = label_highlight,
            },

            label_description = {
              width = { max = 30 },
              highlight = "BlinkCmpLabelDescription",
            },

            -- source labels matching cmp.lua's source_map format
            source_name = {
              width = { max = 8 },
              text = function(ctx)
                local map = {
                  lsp                 = "[LSP ]",
                  buffer              = "[BUF ]",
                  path                = "[PATH]",
                  snippets            = "[SNIP]",
                  copilot             = "[ AI ]",
                  emoji               = "[EMOJ]",
                  spell               = "[SPEL]",
                  nerdfonts           = "[NF  ]",
                  conventionalcommits = "[CONV]",
                  cmdline_history     = "[HIST]",
                }
                return map[ctx.source_name] or ("[" .. ctx.source_name .. "]")
              end,
              highlight = "BlinkCmpSource",
            },
          },
        },
      }

      ------------------------------------------------
      -- COMPLETION BEHAVIOR
      ------------------------------------------------

      opts.completion.trigger = {
        show_on_keyword = true,
        show_on_trigger_character = true,
      }

      opts.completion.list = {
        selection = {
          preselect   = false,
          auto_insert = true,
        },
        cycle = {
          from_bottom = true,
          from_top    = true,
        },
      }

      ------------------------------------------------
      -- DOCUMENTATION
      ------------------------------------------------

      opts.completion.documentation = {
        auto_show = true,
        auto_show_delay_ms = 400,
        window = {
          border = "rounded",
          winhighlight = "Normal:CmpDocNormal",
        },
      }

      ------------------------------------------------
      -- GHOST TEXT
      ------------------------------------------------

      opts.completion.ghost_text = {
        enabled = true,
        show_with_menu = false,
      }

      ------------------------------------------------
      -- SIGNATURE HELP
      ------------------------------------------------

      opts.signature = {
        enabled = false,
        window = { border = "rounded" },
      }

      ------------------------------------------------
      -- COMMANDLINE COMPLETION
      ------------------------------------------------

      opts.cmdline = {
        -- per-mode source routing (mirrors cmp.lua cmdline setup)
        sources = function()
          local t = vim.fn.getcmdtype()
          if t == "/" or t == "?" then
            return { "buffer", "cmdline_history" }
          end
          if t == ":" then
            return { "path", "cmdline", "cmdline_history", "spell" }
          end
          return {}
        end,

        completion = {
          menu = { auto_show = true },
          ghost_text = { enabled = true },
          list = {
            selection = { preselect = true, auto_insert = true },
          },
        },
      }

      ------------------------------------------------
      -- KEYMAPS
      ------------------------------------------------

      opts.keymap = {

        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"]     = { "hide", "fallback" },

        -- scroll docs (mirrors cmp.lua <C-d>/<C-u>)
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up",   "fallback" },

        -- confirm only when item explicitly selected (mirrors cmp.lua <CR>)
        ["<CR>"] = { "accept", "fallback" },

        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then return cmp.snippet_forward() end
          end,
          "select_next",
          "show",     -- trigger completion when words before cursor
          "fallback",
        },

        ["<S-Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then return cmp.snippet_backward() end
          end,
          "select_prev",
          "fallback",
        },

        -- snippet jump (mirrors cmp.lua <C-l>/<C-h>)
        ["<C-l>"] = {
          function(cmp)
            if cmp.snippet_active() then return cmp.snippet_forward() end
          end,
          "fallback",
        },

        ["<C-h>"] = {
          function(cmp)
            if cmp.snippet_active() then return cmp.snippet_backward() end
          end,
          "fallback",
        },

        ["<Up>"]   = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"]  = { "select_prev", "fallback" },
        ["<C-n>"]  = { "select_next", "fallback" },

        ["<A-1>"] = { function(cmp) cmp.accept({ index = 1 }) end },
        ["<A-2>"] = { function(cmp) cmp.accept({ index = 2 }) end },
        ["<A-3>"] = { function(cmp) cmp.accept({ index = 3 }) end },
        ["<A-4>"] = { function(cmp) cmp.accept({ index = 4 }) end },
        ["<A-5>"] = { function(cmp) cmp.accept({ index = 5 }) end },
        ["<A-6>"] = { function(cmp) cmp.accept({ index = 6 }) end },
        ["<A-7>"] = { function(cmp) cmp.accept({ index = 7 }) end },
        ["<A-8>"] = { function(cmp) cmp.accept({ index = 8 }) end },
        ["<A-9>"] = { function(cmp) cmp.accept({ index = 9 }) end },
      }

      return opts
    end,
  }
}
