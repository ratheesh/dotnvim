-- snacks.nvim plugin settings
return {
  {
    "folke/snacks.nvim",
    enabled = true,
    lazy = false,
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
          { section = "terminal", cmd = "figlet NeoViM", hl = "header", padding = 1, indent = 8 },
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
        enabled = false,
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
          modes   = {'n', 'c'},
      },
    },
    --[[ keys = {
      -- File management
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>ff", function()
        local buf_dir = vim.fn.expand("%:p:h")
        local git = vim.fs.find(".git", { path = buf_dir, upward = true })[1]
        Snacks.picker.files({ cwd = git and vim.fs.dirname(git) or buf_dir })
      end, desc = "Files" },
      { "<leader>fo", function()
        Snacks.picker.smart(
          {
            multi   = { "buffers", "recent", "files" },
            format  = "file",
            matcher = {
              cwd_bonus  = true,
              frecency   = true,
              sort_empty = true,
            },
            transform = "unique_file",
          }
        )
      end, desc = "Files" },
      { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent Files" },
      { "<leader>fR", function() Snacks.picker.resume() end, desc = "Resume" },
      { "<leader>ft", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
      { "<leader>/", function()
        local buf_dir = vim.fn.expand("%:p:h")
        local git = vim.fs.find(".git", { path = buf_dir, upward = true })[1]
        Snacks.picker.grep({ cwd = git and vim.fs.dirname(git) or buf_dir })
      end, desc = "Grep" },

      -- Search
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },

      -- LSP
      { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
      { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
      { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
      { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
      { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
      { "gai", function() Snacks.picker.lsp_incoming_calls() end, desc = "C[a]lls Incoming" },
      { "gao", function() Snacks.picker.lsp_outgoing_calls() end, desc = "C[a]lls Outgoing" },
      { "<leader>S", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    }, ]]
  },
  {
    '2kabhishek/seeker.nvim',
    dependencies = { 'folke/snacks.nvim' },
    cmd = { 'Seeker' },
    opts = {},
  }
}

-- End of File
