-- Copyright (c) 2026 Ratheesh<ratheeshreddy@gmail.com>. All Rights Reserved.
-- License: MiT
-- Copilot plugin

return {
  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    enabled = function()
      local ok, spec = pcall(require, "plugins.cmp")
      return ok and spec and spec.enabled ~= false
    end,
    dependencies = { "zbirenbaum/copilot.lua" },
    event = "BufReadPost",
    config = function()
      if not pcall(require, "cmp") then return end
      require("copilot_cmp").setup()
    end,
  },
}
