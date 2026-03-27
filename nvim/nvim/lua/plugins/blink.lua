return {
  {
    "saghen/blink.cmp",
    enabled = false,
    version = '1.*',
    event = { "InsertEnter", "CmdlineEnter" },

    dependencies = {
      "rafamadriz/friendly-snippets",
      "L3MON4D3/LuaSnip",
      "xzbdmw/colorful-menu.nvim",

      {
        "fang2hou/blink-copilot",
        opts = {
          max_completions = 3,
          max_attempts = 2,
        },
      },
    },

    opts = function(_, opts)

      ------------------------------------------------
      -- SOURCES
      ------------------------------------------------

      opts.sources = {
        default = { "copilot", "lsp", "snippets", "path", "buffer" },

        providers = {

          copilot = {
            name = "copilot",
            module = "blink-copilot",

            async = true,
            score_offset = -5,

            opts = {
              max_completions = 3,
              max_attempts = 2,
            },
          },

          lsp = {
            name = "lsp",
            module = "blink.cmp.sources.lsp",
            enabled = true,
            score_offset = 90,
            fallbacks = { "snippets", "buffer" },
          },

          path = {
            name = "Path",
            module = "blink.cmp.sources.path",

            score_offset = 3,
            fallbacks = { "snippets", "buffer" },

            opts = {
              trailing_slash = false,
              label_trailing_slash = true,
              show_hidden_files_by_default = true,

              get_cwd = function(ctx)
                return vim.fn.expand(("#%d:p:h"):format(ctx.bufnr))
              end,
            },
          },

          buffer = {
            name = "Buffer",
            module = "blink.cmp.sources.buffer",
            min_keyword_length = 2,
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

      local function label_text(ctx)
        local info = require("colorful-menu").blink_highlights(ctx)
        return info and info.label or ctx.label
      end

      local function label_highlight(ctx)
        local highlights = {}
        local info = require("colorful-menu").blink_highlights(ctx)

        if info then
          highlights = info.highlights
        end

        for _, idx in ipairs(ctx.label_matched_indices) do
          table.insert(highlights, {
            idx,
            idx + 1,
            group = "BlinkCmpLabelMatch",
          })
        end

        return highlights
      end

      opts.completion.menu = {

        border = "rounded",
        max_height = 12,

        draw = {

          padding = 1,
          gap = 1,

          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "source_name" },
          },

          components = {

            label = {
              width = { fill = true, max = 40 },
              text = label_text,
              highlight = label_highlight,
            },

            label_description = {
              width = { max = 30 },
              highlight = "BlinkCmpLabelDescription",
            },

            source_name = {
              width = { max = 8 },

              text = function(ctx)
                local map = {
                  lsp = "LSP",
                  buffer = "BUF",
                  path = "PATH",
                  snippets = "SNIP",
                  copilot = "COP",
                }

                return map[ctx.source_name] or ctx.source_name
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
          preselect = false,
          auto_insert = false,
        },

        cycle = {
          from_bottom = true,
          from_top = true,
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
        },
      }

      ------------------------------------------------
      -- GHOST TEXT (Copilot style)
      ------------------------------------------------

      opts.completion.ghost_text = {

        enabled = true,
        show_with_menu = false,
      }

      ------------------------------------------------
      -- SIGNATURE HELP
      ------------------------------------------------

      opts.signature = {

        enabled = true,

        window = {
          border = "rounded",
        },
      }

      ------------------------------------------------
      -- COMMANDLINE COMPLETION
      ------------------------------------------------

      opts.cmdline = {

        completion = {

          menu = {
            auto_show = true,
          },

          list = {
            selection = {
              preselect = false,
              auto_insert = false,
            },
          },
        },
      }

      ------------------------------------------------
      -- KEYMAPS
      ------------------------------------------------

      opts.keymap = {

        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<CR>"] = { "accept", "fallback" },

        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.snippet_forward()
            end
          end,
          "select_next",
          "fallback",
        },

        ["<S-Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.snippet_backward()
            end
          end,
          "select_prev",
          "fallback",
        },

        ["<C-l>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.snippet_forward()
            end
          end,
          "fallback",
        },

        ["<C-h>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.snippet_backward()
            end
          end,
          "fallback",
        },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },

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
