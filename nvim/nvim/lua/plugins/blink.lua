return {
  {
    'saghen/blink.cmp',
    lazy = false,
    dependencies = 'rafamadriz/friendly-snippets',

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
                    if cmp.is_in_snippet() then return cmp.snippet_forward()
                    else return cmp.select_next() end
                end,
                'select_next',
                'fallback'
            },
            ['<S-Tab>'] = {
                function(cmp)
                    if cmp.is_in_snippet() then return cmp.snippet_backward()
                    else return cmp.select_prev() end
                end,
                'select_prev',
                'fallback'
            },

            ['<Up>'] = { 'select_prev', 'fallback' },
            ['<Down>'] = { 'select_next', 'fallback' },
            ['<C-p>'] = { 'select_prev', 'fallback' },
            ['<C-n>'] = { 'select_next', 'fallback' },

            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        },

      highlight = {
        use_nvim_cmp_as_default = true,
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
        ghost_text = {
          enabled = true,
        },
      },
    }
  },
}

-- End of File
