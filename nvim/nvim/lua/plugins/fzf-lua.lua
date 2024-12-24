local M = {
  'ibhagwan/fzf-lua',
  enabled = true,
  event = 'VimEnter',
  cmd = { 'Fz' },

  dependencies = {
    {'nvim-tree/nvim-web-devicons'}
  },
}


function M.config()
  -- print('initializing fzf-lua')
  -- require('fzf-lua').setup()
  require('fzf-lua').setup({
      winopts = {
        preview = { default = "bat", hidden = 'hidden' },
        height = 0.5,
        width  = 0.75,
      },
      fzf_opts = {
       ["--layout"] = false,
      },
    })
end

function M.init()
  local function map(mode, l, r, opts)
    opts = opts or {}
    vim.keymap.set(mode, l, r, opts)
  end
  vim.keymap.set("n", "<leader>fo", require('fzf-lua').files, { desc = "Fzf Files" })
  -- map('n', '<leader>fo', '<cmd>FzfLua files --keep-right=true --preview-window=hidden formatter=path.filename_first<CR>')
  -- map('n', '<leader>fo', '<cmd>lua require'fzf-lua'.files({ fzf_opts = { }})<CR>')
  map('n', '<leader>fr', '<cmd>FzfLua oldfiles<CR>')
  map('n', '<leader>ft', '<cmd>FzfLua btags<CR>')
  map('n', '<leader>/',  '<cmd>FzfLua live_grep<CR>')
  map('n', '<leader>fR', '<cmd>FzfLua resume<CR>')
  -- map('n', '<leader>ca', '<cmd>FzfLua lsp_code_actions<CR>')
  map('n', '<leader>g/', '<cmd>FzfLua lsp_workspace_symbols<CR>')
  -- map('n', 'gd', '<cmd>FzfLua lsp_definitions<CR>')
  -- map('n', 'gD', '<cmd>FzfLua lsp_declarations<CR>')
  -- map('n', 'gr', '<cmd>FzfLua lsp_references<CR>')
end

return M
