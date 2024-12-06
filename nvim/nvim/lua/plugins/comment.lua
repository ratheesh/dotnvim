local M = {
  'numToStr/Comment.nvim',
  event = 'VeryLazy',
  keys = { 'gc', 'gcc', 'gb', 'gbc', '<A-;>' },
}

function M.config()
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
end
return M
