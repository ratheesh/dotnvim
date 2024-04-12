-- Copyright (c) 2023 Ratheesh <ratheeshreddy@gmail.com>
-- License: MIT
-- Gitsigns plugin config

local M = {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
}

function M.config()
  require('gitsigns').setup({
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')
      -- local gs = package.loaded.gitsigns
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      vim.api.nvim_create_user_command("Stage", function(t) gitsigns.stage_hunk({ t.line1, t.line2 }) end, { range = true })
      vim.api.nvim_create_user_command("Reset", function(t) gitsigns.reset_hunk({ t.line1, t.line2 }) end, { range = true })
    end,
    signs = {
      add          = { text = "│" },
      change       = { text = "│" },
      delete       = { text = "│" },
      topdelete    = { text = "▾" },
      changedelete = { text = "│" },
      untracked    = { text = "│" },
    },
    diff_opts = {
      internal = true,
    },
    preview_config = {
      border   = 'rounded',
      style    = 'minimal',
      relative = 'cursor',
      row      = 0,
      col      = 1
    }
  })
end

return M
