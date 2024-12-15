return {
  {
    'saghen/blink.cmp',
    enabled = true,
    lazy = false,
    dependencies ={ 
      'rafamadriz/friendly-snippets',
      'L3MON4D3/LuaSnip'
    },

    version = 'v0.*',
    opts = {
        keymap = {
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

            -- ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            -- ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

            ['<A-1>'] = { function(cmp) cmp.accept({ index = 1 }) end },
            ['<A-2>'] = { function(cmp) cmp.accept({ index = 2 }) end },
            ['<A-3>'] = { function(cmp) cmp.accept({ index = 3 }) end },
            ['<A-4>'] = { function(cmp) cmp.accept({ index = 4 }) end },
            ['<A-5>'] = { function(cmp) cmp.accept({ index = 5 }) end },
            ['<A-6>'] = { function(cmp) cmp.accept({ index = 6 }) end },
            ['<A-7>'] = { function(cmp) cmp.accept({ index = 7 }) end },
            ['<A-8>'] = { function(cmp) cmp.accept({ index = 8 }) end },
            ['<A-9>'] = { function(cmp) cmp.accept({ index = 9 }) end },
        },
        snippets = {
          expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
          active = function(filter)
            if filter and filter.direction then
              return require('luasnip').jumpable(filter.direction)
            end
            return require('luasnip').in_snippet()
          end,
          jump = function(direction) require('luasnip').jump(direction) end,
        },
        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer' },
          cmdline = { 'lsp', 'path', 'buffer' },
        },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'normal',
      },

      -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'normal',

      -- experimental auto-brackets support
      accept = { auto_brackets = { enabled = true } },

      -- experimental signature help support
      -- trigger = { signature_help = { enabled = true } },
      windows = {
        autocomplete = {
          border = "rounded",
        },
        documentation = {
          border             = 'rounded',
          auto_show          = true,
          auto_show_delay_ms = 500,
          update_delay_ms    = 50,
        },
      },
      completion = {
        menu = {
          border = 'rounded',
          draw = {
            columns = { { 'item_idx' }, { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
            components = {
              item_idx = {
                text = function(ctx) return tostring(ctx.idx) end,
                highlight = 'BlinkCmpItemIdx',
              }
            }
          }
        },
        list = {
          selection = 'manual',
        },
        ghost_text = {
          enabled = true,
        },
      },
    },
  },
}

-- End of File
