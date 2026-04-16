-- pulse.nvim plugin settings
return {
  {
    "willyelm/pulse.nvim",
    enabled = false,
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
      -- File management
      { "<leader>fo",  "<cmd>Pulse<cr>",                  desc = "Files" },
      { "<leader>ff",  "<cmd>Pulse git<cr>",              desc = "Git Files" },
      { "<leader>ft",  "<cmd>Pulse symbols<cr>",          desc = "LSP Symbols" },
      { "<leader>fT",  "<cmd>Pulse workspace_symbols<cr>", desc = "Workspace Symbols" },

      -- Search
      { "<leader>/",   "<cmd>Pulse live_grep<cr>",        desc = "Live Grep" },
      { "<leader>sf",  "<cmd>Pulse fuzzy_search<cr>",     desc = "Fuzzy Search" },

      -- Diagnostics / LSP
      { "<leader>sd",  "<cmd>Pulse diagnostics<cr>",      desc = "Diagnostics" },
      { "<leader>sc",  "<cmd>Pulse code_actions<cr>",     desc = "Code Actions" },
    },
  }
}
-- End of File
