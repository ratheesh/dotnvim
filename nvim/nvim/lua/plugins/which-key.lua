-- Copyright (c) 2024 Ratheesh <ratheeshreddy@gmail.com>
-- License: MiT
-- which-key configuration

return {
  "folke/which-key.nvim",
  enabled = false,
  event = "VeryLazy",
  opts = {
    preset   = "helix",
    delay    = 700,
    triggers = { "<auto>" },
    icons = {
      breadcrumb = "»",
      separator  = "➜ ",
      group      = " ",
      ellipsis   = "…",
    },
    win = {
      no_overlap = true,
      border     = "rounded",
      padding    = { 1, 1 },
      title      = true,
      title_pos  = "center",
      zindex     = 1000,
      height     = { min = 4, max = 10 },
      wo         = { winblend = 5 },
    },
    plugins = {
      marks = false,
    },
  },
}
-- End of File
