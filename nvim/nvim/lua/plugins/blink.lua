return {
  {
    'saghen/blink.cmp',
    enabled = true,
    event = "VeryLazy",
    lazy = false,
    dependencies ={ 
      'rafamadriz/friendly-snippets',
      'L3MON4D3/LuaSnip'
    },

    version = 'v0.*',
    opts = function(_, opts)
      opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
        default = { "lsp", "path", "snippets", "buffer", "luasnip" },
        providers = {
          lsp = {
            name = "lsp",
            enabled = true,
            module = "blink.cmp.sources.lsp",
            fallbacks = { "snippets", "luasnip", "buffer" },
            score_offset = 90,
          },
          luasnip = {
            name = "luasnip",
            enabled = true,
            module = "blink.cmp.sources.luasnip",
            min_keyword_length = 2,
            fallbacks = { "snippets" },
            score_offset = 85,
          },
          path = {
            name = "Path",
            module = "blink.cmp.sources.path",
            score_offset = 3,
            fallbacks = { "snippets", "luasnip", "buffer" },
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
          snippets = {
            name = "snippets",
            enabled = true,
            module = "blink.cmp.sources.snippets",
            score_offset = 80,
          },
        },
      })
      opts.snippets = {
        expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
        active = function(filter)
          if filter and filter.direction then
            return require('luasnip').jumpable(filter.direction)
          end
          return require('luasnip').in_snippet()
        end,
        jump = function(direction) require('luasnip').jump(direction) end,
      }
      opts.appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'normal',
      }
      opts.completion = {
        menu = {
          max_height = 12,
          min_width  = 60,
          border     = 'rounded',
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
        list = {
          selection = 'manual',
        },
        documentation = {
          auto_show = true,
          window = {
            border = "rounded",
          }
        },
        ghost_text = {
          enabled = true,
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
