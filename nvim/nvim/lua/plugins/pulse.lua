-- Copyright (c) 2026 Ratheesh<ratheeshreddy@gmail.com>. All Rights Reserved.
-- License:MiT
-- pulse plugin config
--

return {
  {
    "willyelm/pulse.nvim",
    opts = {
      cmdline         = false,
      position        = "center",
      width           = 0.70,
      height          = 0.70,
      border          = "rounded",
      workspace_label = false,
      navigators = {
        files = {
          open_on_directory = true,
          icons = true,
          filters = { "^%.git$", "%.DS_Store$" },
          git = {
            enable = true,
            ignore = false,
          },
        },
      },
    },
    keys = {
      { "<leader>fo", "<cmd>Pulse<cr>", desc = "Open Pulse" },
      { "<leader>ff", "<cmd>Pulse git<cr>", desc = "Open git files" },
      { "<leader>ft", "<cmd>Pulse symbols<cr>", desc = "Open buffer symbols" },
      { "<leader>fT", "<cmd>Pulse workspace_symbols<cr>", desc = "Open workspace symbols" },
      { "<leader>/", "<cmd>Pulse live_grep<cr>", desc = "Live Grep" },
    },
  }
}
-- End of File
