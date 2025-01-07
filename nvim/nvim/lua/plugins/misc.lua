return {
  {
    'antoyo/vim-licenses',
    cmd = { 'Gplv2', 'Apache', 'Mit' },
    config = function ()
      vim.g.licenses_copyright_holders_name = 'Ratheesh <ratheeshreddy@gmail.com>'
      vim.g.licenses_authors_name           = 'Ratheesh S'
      vim.g.licenses_default_commands       = { 'Gplv2', 'Apache', 'Mit' }
    end
  },
  {
    "preservim/tagbar",
    cmd = { "Tagbar" },
    config = function()

    end
  },
  {
    "tris203/precognition.nvim",
    enabled = false,
    event = "VeryLazy",
    config = function()
      require("precognition").setup({})
    end
  },
  -- lazy.nvim
  {
    "folke/snacks.nvim",
    enabled = true,
    event   = "UIEnter",
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

      }
    }
  },
}

-- End of File
