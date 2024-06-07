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
    icons = {
      breadcrumb = "»",
      separator  = "➜",
      group      = " ",
    },
    window = {
      border   = "rounded",
      position = "bottom",
      margin   = { 1, 0, 1, 0 },
      padding  = { 1, 2, 1, 2 },
      winblend = 0,
      zindex   = 1000,
    },
  }
}
-- End of File
