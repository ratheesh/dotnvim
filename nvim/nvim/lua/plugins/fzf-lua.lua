local M = {
  'ibhagwan/fzf-lua',
  enabled = false,
  event = 'VimEnter',
  cmd = { 'Fz' },

  dependencies = {
    {'nvim-tree/nvim-web-devicons'}
  },
}


function M.config()
  -- print('initializing fzf-lua')
  -- require('fzf-lua').setup()
  require('fzf-lua').setup({'fzf-native'})
end

function M.init()
  local function map(mode, l, r, opts)
    opts = opts or {}
    vim.keymap.set(mode, l, r, opts)
  end
  map('n', '<leader>fo', '<cmd>FzfLua files<CR>')
  map('n', '<leader>fr', '<cmd>FzfLua oldfiles<CR>')
  map('n', '<leader>ft', '<cmd>FzfLua btags<CR>')
  map('n', '<leader>/',  '<cmd>FzfLua live_grep<CR>')
  map('n', '<leader>fR', '<cmd>FzfLua resume<CR>')
  map('n', '<leader>ca', '<cmd>FzfLua lsp_code_actions<CR>')
  map('n', '<leader>g/', '<cmd>FzfLua lsp_workspace_symbols<CR>')
  map('n', 'gd', '<cmd>FzfLua lsp_definitions<CR>')
  map('n', 'gD', '<cmd>FzfLua lsp_declarations<CR>')
  map('n', 'gr', '<cmd>FzfLua lsp_references<CR>')
end

return M
