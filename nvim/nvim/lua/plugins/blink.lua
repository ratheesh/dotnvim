return {
  {
    'saghen/blink.cmp',
    enabled = true,
    event = "VeryLazy",
    lazy = false,
    dependencies ={
      'rafamadriz/friendly-snippets',
      'L3MON4D3/LuaSnip',
      'xzbdmw/colorful-menu.nvim',
      {
        "fang2hou/blink-copilot",
        opts = {
          max_completions = 1,
          max_attempts = 2,
        }
      },
    },

    version = 'v1.*',
    opts = function(_, opts)
      opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
        default = { "copilot", "lsp", "snippets", "path", "buffer" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
            opts = {
              max_completions = 5,
              max_attempts    = 3,
            }
          },
          lsp = {
            name = "lsp",
            enabled = true,
            module = "blink.cmp.sources.lsp",
            fallbacks = { "snippets", "buffer" },
            score_offset = 90,
          },
          path = {
            name = "Path",
            module = "blink.cmp.sources.path",
            score_offset = 3,
            fallbacks = { "snippets", "buffer" },
            opts = {
              trailing_slash = false,
              label_trailing_slash = true,
              get_cwd = function(context)
                return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
              end,
              show_hidden_files_by_default = true,
            },
          },
          buffer = {
            name = "Buffer",
            module = "blink.cmp.sources.buffer",
            min_keyword_length = 2,
          },
        },
      })
      opts.fuzzy = { implementation = "prefer_rust" }
      opts.appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'normal',
      }
      opts.completion = {
        menu = {
          max_height = 12,
          -- min_width  = 10,
          border     = 'rounded',
          draw = {
            align_to = "label",
            padding  = 1,
            gap      = 1,
            columns = { { "kind_icon" }, { "label", "label_description", gap = 1, "kind" } },
            components = {
              label = {
                width = { fill = true, max = 40 },
                text = function(ctx)
                  local highlights_info = require("colorful-menu").blink_highlights(ctx)
                  if highlights_info ~= nil then
                    -- Or you want to add more item to label
                    return highlights_info.label
                  else
                    return ctx.label
                  end
                end,
                highlight = function(ctx)
                  local highlights = {}
                  local highlights_info = require("colorful-menu").blink_highlights(ctx)
                  if highlights_info ~= nil then
                    highlights = highlights_info.highlights
                  end
                  for _, idx in ipairs(ctx.label_matched_indices) do
                    table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                  end
                  -- Do something else
                  return highlights
                end,
              },
              label_description = {
                width = { max = 30 },
                text = function(ctx) return ctx.label_description end,
                highlight = 'BlinkCmpLabelDescription',
              },

              source_name = {
                width = { max = 30 },
                text = function(ctx) return ctx.source_name end,
                highlight = 'BlinkCmpSource',
              },

              source_id = {
                width = { max = 30 },
                text = function(ctx) return ctx.source_id end,
                highlight = 'BlinkCmpSource',
              },
            },
          },
          --[[ draw = {
            columns = { { 'item_idx' }, { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
            components = {
              item_idx = {
                text = function(ctx) return tostring(ctx.idx) end,
                highlight = 'BlinkCmpItemIdx',
              }
            }
          } ]]
        },
        trigger = {
          show_on_keyword = true,
          show_on_backspace = true,
          show_on_backspace_in_keyword = true,
          show_on_backspace_after_accept = true,
          show_on_backspace_after_insert_enter = true,
          show_on_trigger_character = true,
          show_on_insert = true,
        },
        list = {
          selection = {
            preselect = false,
            auto_insert = true,
          },
          cycle = {
            from_bottom = true,
            from_top = true,
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
          window = {
            border = "rounded",
          }
        },
        ghost_text = {
          enabled = true,
          show_with_menu = true,
          show_without_selection = true,
        },
      }

      opts.cmdline = {
        completion = {
          menu = {
            auto_show = true
          },
          list = {
            selection = {
              preselect   = false,
              auto_insert = true,
            },
          },
        },
      }
      opts.keymap = {
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },

        --[[ ['<Tab>'] = { 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' }, ]]

        ['<Tab>'] = {
          function(cmp)
            if cmp.snippet_active() then return cmp.snippet_forward()
            else return cmp.select_next() end
          end,
          'select_next',
          'fallback'
        },
        ['<S-Tab>'] = {
          function(cmp)
            if cmp.snippet_backward() then return cmp.snippet_backward()
            else return cmp.select_prev() end
          end,
          'select_prev',
          'fallback'
        },

        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },

        ['<A-1>'] = { function(cmp) cmp.accept({ index = 1 }) end },
        ['<A-2>'] = { function(cmp) cmp.accept({ index = 2 }) end },
        ['<A-3>'] = { function(cmp) cmp.accept({ index = 3 }) end },
        ['<A-4>'] = { function(cmp) cmp.accept({ index = 4 }) end },
        ['<A-5>'] = { function(cmp) cmp.accept({ index = 5 }) end },
        ['<A-6>'] = { function(cmp) cmp.accept({ index = 6 }) end },
        ['<A-7>'] = { function(cmp) cmp.accept({ index = 7 }) end },
        ['<A-8>'] = { function(cmp) cmp.accept({ index = 8 }) end },
        ['<A-9>'] = { function(cmp) cmp.accept({ index = 9 }) end },
      }
      return opts
    end
  },
}

-- End of File
