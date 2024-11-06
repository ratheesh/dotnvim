return {
  {
    'saghen/blink.cmp',
    lazy = false,
    dependencies = 'rafamadriz/friendly-snippets',

    version = 'v0.*',
    opts = {
      keymap = { preset = 'enter' },

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
