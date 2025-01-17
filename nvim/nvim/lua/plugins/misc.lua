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
}

-- End of File
