-- Copyright (c) 2026 Ratheesh<ratheeshreddy@gmail.com>. All Rights Reserved.
-- License: MiT
-- Author: Ratheesh <ratheeshreddy@gmail.com>
-- wayfinder.nvim: A Neovim plugin for file navigation and searching, inspired by Telescope and FZF.

return {
  "error311/wayfinder.nvim",
  enabled = true,
  event = { "LspAttach", "BufReadPost" },
  keys = {
    { "<leader>wf", "<Plug>(WayfinderOpen)", desc = "Wayfinder" },
  },
  opts = {
    layout = {
      width = 0.88,
      height = 0.72,
    },
  },
}
