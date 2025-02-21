-- snacks.nvim plugin settings
return {
  {
    "folke/snacks.nvim",
    enabled = true,
    event   = "VeryLazy",
    opts    = {
      bigfile = { enabled = true },
      notifier = { enabled = true, timeout = 2000 },
      dashboard = {
        enabled = true,
        formats = {
          key = function(item)
            return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
          end,
        },
        sections = {
          { section = "terminal", cmd = "fortune -s | cowsay", hl = "header", padding = 1, indent = 8 },
          { title   = "MRU", padding = 1 },
          { section = "recent_files", limit = 8, padding = 1 },
          { title   = "MRU ", file = vim.fn.fnamemodify(".", ":~"), padding = 1 },
          { section = "recent_files", cwd = true, limit = 8, padding = 1 },
          { title   = "Sessions", padding = 1 },
          { section = "projects", padding = 1 },
          { title   = "Bookmarks", padding = 1 },
          { section = "keys" },
        },
      },
      picker = {
        win = {
          input = {
            keys ={
              ["<Esc>"] = { "close", mode = "i" },
              ["<C-c>"] = { "close", mode = "i" },
            }
          },
        },
      },
      words = {
          enabled = true,
      },
    },
    keys = {
      -- File management
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Files" },
      { "<leader>fo", function() Snacks.picker.smart() end, desc = "Files" },
      { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent Files" },
      { "<leader>fR", function() Snacks.picker.resume() end, desc = "Resume" },

      -- Search
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },

      -- LSP
      { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
      { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
      { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
      { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
      -- { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    },
  }
}

-- End of File
