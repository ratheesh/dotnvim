local M = {
  'nvimtools/hydra.nvim',
  keys = { '<leader>,' },
  dependencies = {
    'anuvyklack/keymap-layer.nvim',
    'brenoprata10/nvim-highlight-colors',
    'lewis6991/gitsigns.nvim',
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
  ^_<Enter>_: Neogit    _q_/_<Esc>_: Exit
  ]]
  Hydra({
    name = "Git",
    hint = hint,
    config = {
      color = "pink",
      invoke_on_body = true,
      hint = {
        offset     = 1,
        position   = 'middle-right',
        float_opts = { border = "rounded" },
      },
      on_enter = function()
        vim.cmd('echo')
        vim.cmd('set nohlsearch')
        vim.cmd('set nocursorline')
        vim.cmd([[HighlightColors off]])
        vim.cmd 'mkview'
        vim.cmd 'silent! %foldopen!'
        gitsigns.toggle_signs(true)
        gitsigns.toggle_word_diff(true)
        require('util').toggle.inlay_hints(0, false)
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
        vim.cmd([[HighlightColors on]])
        vim.cmd('set hlsearch')
        vim.cmd('set cursorline')
        require('util').toggle.inlay_hints(0, true)
      end
    },
    mode = { 'n', 'x' },
    body = '<leader>,',
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
      { 's', gitsigns.stage_hunk,          { silent = true, desc = 'Stage Hunk'         }},
      { 'u', gitsigns.undo_stage_hunk,     { desc = 'Undo Staged Hunk'                  }},
      { 'S', gitsigns.stage_buffer,        { desc = 'Stage Buffer'                      }},
      { 'r', gitsigns.reset_hunk,          { desc = 'Reset Hunk'                        }},
      { 'p', gitsigns.preview_hunk,        { desc = 'Preview Hunk'                      }},
      { 'i', gitsigns.preview_hunk_inline, { desc = 'Preview Hunk Inline'               }},
      { 'd', gitsigns.toggle_deleted,      { nowait = true                               }},
      { 'D', gitsigns.toggle_word_diff,    { nowait = true                               }},
      { 'b', gitsigns.blame_line,          { desc = 'Blame Line'                        }},
      { 'B', function() gitsigns.blame_line{ full = true } end, { desc = 'Blame Full'   }},
      { '/', gitsigns.show,                { exit = true,   desc = 'Show Base File'     }},
      { '<Enter>', '<cmd>Neogit<CR>',     { exit = true                    }},
      { '<Esc>',   nil,                   { exit = true,     nowait = true }},
      { 'q',       nil,                   { exit = true,     nowait = true }},
    }
  })
end
return M
