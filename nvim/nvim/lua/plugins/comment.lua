-- Copyright (c) 2026 Ratheesh<ratheeshreddy@gmail.com>. All Rights Reserved.
-- License: MiT

return {
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    enabled =false,
    keys = { 'gc', 'gcc', 'gb', 'gbc', '<M-;>', '<M-:>' },

    config = function ()
      require('Comment').setup({
        padding = true,
        sticky = true,
        ignore = nil,

        toggler = {
          line = 'gcc',
          block = 'gbc',
        },
        opleader = {
          line = 'gc',
          block = 'gb',
        },

        extra = {
          above = 'gbO',
          below = 'gbo',
          eol = '<M-;>',
        },

        mappings = {
          basic = true,
          extra = true,
        },

        pre_hook = nil,
        post_hook = nil,
      })

      vim.keymap.set('n', '<M-:>', function()
        require('Comment.api').insert.blockwise.eol()
      end, { desc = 'Block comment at end of line' })
    end
  },
  {
    "celeste3z/celeste_comment.nvim",
    lazy = false,
    opts = {},
  },
}
-- End of file
