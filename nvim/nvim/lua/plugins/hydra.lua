local M = {
  'nvimtools/hydra.nvim',
  -- event = 'VeryLazy',
  keys = { '<space>g' },
  dependencies = {
    'anuvyklack/keymap-layer.nvim',
    -- 'NvChad/nvim-colorizer.lua',
    'brenoprata10/nvim-highlight-colors',
  },
}

function M.config()
  local Hydra = require('hydra')
  local gitsigns = require('gitsigns')

  local hint = [[
  _0_: First Hunk      _$_: Last Hunk       ^ ^
  _j_: Next Hunk       _k_: Prev Hunk       ^ ^
  _d_: Show Deleted    _D_: Word Diff       ^ ^
  _u_: Undo Stage Hunk _r_: reset Hunk      ^ ^
  _b_: Blame Line      _B_: Blame Show Full ^ ^
  _s_: Stage Hunk      _S_: Stage Buffer    ^ ^
  _i_: inline Preview  _p_: Preview Hunk    ^ ^
  _/_: Show Base File
  ^
  ^_<Enter>_: Neogit    q_/<Esc>: Exit
  ]]
  Hydra({
    name = "Git",
    hint = hint,
    config = {
      color = "pink",
      invoke_on_body = true,
      -- buffer = bufnr,
      hint = {
        offset   = 1,
        position = 'middle-right',
        -- border   = "rounded"
        float_opts = {
        border   = "rounded"
        },
      },
      on_enter = function()
        vim.cmd('echo')
        vim.cmd('set nohlsearch')
        vim.cmd('set nocursorline')
        -- vim.cmd('ShowkeysToggle')
        -- vim.cmd([[ColorizerDetachFromBuffer]])
        vim.cmd([[HighlightColors off]])
        -- vim.cmd([[CccHighlighterDisable]])
        vim.cmd 'mkview'
        vim.cmd 'silent! %foldopen!'
        gitsigns.toggle_signs(true)
        -- gitsigns.toggle_linehl(true)
        gitsigns.toggle_word_diff(true)
      end,
      on_exit = function()
        vim.cmd('echo')
        local cursor_pos = vim.api.nvim_win_get_cursor(0)
        vim.cmd 'loadview'
        vim.api.nvim_win_set_cursor(0, cursor_pos)
        vim.cmd 'normal zv'
        gitsigns.toggle_signs(true)
        gitsigns.toggle_linehl(false)
        gitsigns.toggle_deleted(false)
        gitsigns.toggle_word_diff(false)
        -- vim.cmd([[CccHighlighterEnable]])
        -- vim.cmd([[ColorizerAttachToBuffer]])
        vim.cmd([[HighlightColors on]])
        vim.cmd('set cursorline')
        -- vim.cmd('ShowkeysToggle')
      end
    },
    mode = { 'n', 'x' },
    body = '<leader>g',
    heads = {
      { 'j', function()
        if vim.wo.diff then return ']c' end
        gitsigns.nav_hunk('next', { wrap = false })
        return '<Ignore>'
      end, { expr = true }},
      { 'k', function()
        if vim.wo.diff then return '[c' end
        gitsigns.nav_hunk('prev', { wrap = false })
        return '<Ignore>'
      end, { expr = true }},
      { '0', function()
        if vim.wo.diff then return '[H' end
        gitsigns.nav_hunk('first', { wrap = false })
        return '<Ignore>'
      end, { expr = true }},
      { '$', function()
        if vim.wo.diff then return ']H' end
        gitsigns.nav_hunk('last', { wrap = false })
        return '<Ignore>'
      end, { expr = true }},
      { 's', gitsigns.stage_hunk,          { silent = true                 }},
      { 'u', gitsigns.undo_stage_hunk,     { desc = 'Undo Staged Hunk'     }},
      { 'S', gitsigns.stage_buffer,        { desc = 'Stage buffer'         }},
      { 'r', gitsigns.reset_hunk,          { desc = 'Reset Hunk'           }},
      { 'p', gitsigns.preview_hunk,        { desc = 'Preview Hunk'         }},
      { 'i', gitsigns.preview_hunk_inline, { desc = 'Preview Hunk'         }},
      { 'd', gitsigns.toggle_deleted,      { nowait = true                 }},
      { 'D', gitsigns.toggle_word_diff,    { nowait = true                 }},
      { 'b', gitsigns.blame_line,          { desc = "Blame Line"           }},
      { 'B', function() gitsigns.blame_line { full = true              }end },
      { '/',       gitsigns.show,         { exit = true                    }},
      { '<Enter>', '<cmd>Neogit<CR>',     { exit = true                    }},
      { '<Esc>',   nil,                   { exit = true,     nowait = true }},
      { 'q',       nil,                   { exit = true,     nowait = true }},
    }
  })
end
return M
