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
    "Lachignol/time-bomb.nvim",
    cmd = { 'TimeBomb' },
    config = function()
      require("time-bomb").setup({
        enable_default_keymaps = true,
        timer_color = "lime",
      })
    end,
  },
}

-- End of File
