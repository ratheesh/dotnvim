-- Copyright (c) 2024 Ratheesh <ratheeshreddy@gmail.com>
-- License: MiT
-- which-key configuration

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 700
  end,
  opts = {
    reset = 'helix',
    icons = {
      breadcrumb = "»",
      separator  = "➜ ",
      group      = " ",
      ellipsis   = "…",
    },
    win = {
      no_overlap = true,
      border     = "rounded",
      padding    = { 1, 1 },
      title      = true,
      title_pos  = "center",
      zindex     = 1000,
      height = { min = 4, max = 10 },

      bo = {},
      wo = {
        winblend = 5,
      },
    },
    plugins = {
      marks = false,
    },
  }
}
-- End of File
