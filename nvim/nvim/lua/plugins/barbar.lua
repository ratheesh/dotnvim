local M = {
  'romgrk/barbar.nvim',
  enabled=false,
  event = "BufReadPre",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}

function M.config()
  require('barbar').setup({
    animation    = true,
    auto_hide    = false,
    tabpages     = false,
    closable     = true,
    clickable    = true,
    exclude_name = {'package.json', "COMMIT_EDITMSG"},
    icons        = {
      buffer_index = true,
      buffer_number = false,
      button = ' ✗',
      filetype = {enabled = true},
      inactive = {button=' ✗', separator = {left = ' ', right = ''}},
      modified = {button = ' ●'},
      pinned   = {button = ' 車'},
      -- separator = {left = '▎', right = ''},
      separator = {left = ' ', right=''},

      diagnostics = {
        [vim.diagnostic.severity.ERROR] = {enabled = true},
        [vim.diagnostic.severity.WARN]  = {enabled = false},
        [vim.diagnostic.severity.INFO]  = {enabled = false},
        [vim.diagnostic.severity.HINT]  = {enabled = true},
      },
    },
    insert_at_end           = false,
    insert_at_start         = false,
    maximum_padding         = 0,
    minimum_padding         = 0,
    maximum_length          = 20,
    semantic_letters        = true,
    letters                 = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
    no_name_title           = nil,
  })

  local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
  end

  -- Move to previous/next
  map('n', '<Leader>h', '<Cmd>BufferPrevious<CR>', { desc = 'Goto Previous Buffer' })
  map('n', '<Leader>l', '<Cmd>BufferNext<CR>',     { desc = 'Goto Next Buffer'     })

  -- jump to buffer index
  map('n', '<Leader>1', '<Cmd>BufferGoto 1<CR>', { desc = 'Goto Buffer 1' })
  map('n', '<Leader>2', '<Cmd>BufferGoto 2<CR>', { desc = 'Goto Buffer 2' })
  map('n', '<Leader>3', '<Cmd>BufferGoto 3<CR>', { desc = 'Goto Buffer 3' })
  map('n', '<Leader>4', '<Cmd>BufferGoto 4<CR>', { desc = 'Goto Buffer 4' })
  map('n', '<Leader>5', '<Cmd>BufferGoto 5<CR>', { desc = 'Goto Buffer 5' })
  map('n', '<Leader>6', '<Cmd>BufferGoto 6<CR>', { desc = 'Goto Buffer 6' })
  map('n', '<Leader>7', '<Cmd>BufferGoto 7<CR>', { desc = 'Goto Buffer 7' })
  map('n', '<Leader>8', '<Cmd>BufferGoto 8<CR>', { desc = 'Goto Buffer 8' })
  map('n', '<Leader>9', '<Cmd>BufferGoto 9<CR>', { desc = 'Goto Buffer 9' })

  map('n', '<A-p>', '<Cmd>BufferPin<CR>',          { desc = 'Pin Buffer'         })
  map('n', '<A-d>', '<Cmd>bdelete<CR>',            { desc = 'Delete Current Buf' })
  map('n', '<C-s>', '<Cmd>BufferPick<CR>',         { desc = 'Pick Buffer'        })
  map('n', '<A->>', '<Cmd>BufferMoveNext<CR>',     { desc = 'Move Buffer Right'  })
  map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', { desc = 'Move Buffer Left'   })
  map('n', '<C-j>', '<Cmd>BufferLast<CR>',         { desc = "Previous Buffer"    })

  --[[ local hl = vim.api.nvim_set_hl
  hl(0, "BufferCurrent"           ,{ fg = "#99c794", bg = "#595B7C", italic = true,  bold = true, underline = false })
  hl(0, "BufferCurrentIndex"      ,{ fg = "#e7b898", bg = "#595B7C", italic = false, bold = false, underline = false })
  hl(0, "BufferCurrentIcon"       ,{ fg = nil      , bg = "#595B7C", italic = false, bold = false, underline = false })
  hl(0, "BufferDefaultCurrentIcon",{ fg = nil      , bg = "#595B7C", italic = false, bold = false, underline = false })
  hl(0, "BufferCurrentMod"        ,{ fg = "#E79498", bg = "#595B7C", italic = true,  bold = false, underline = false })
  hl(0, "BufferCurrentTarget"     ,{ fg = "#FA2C77", bg = "#595B7C", italic = true , bold = true , underline = true  })
  hl(0, "BufferCurrentSign"       ,{ fg = "#595B7C", bg = "#383a4c", italic = false, bold = false, underline = false })

  hl(0, "BufferInActive"          ,{ fg = "#99c794", bg = "#383a4c", italic = false, bold = false, underline = false })
  hl(0, "BufferInactiveIndex"     ,{ fg = "#988C99", bg = "#383a4c", italic = false, bold = false, underline = false })
  hl(0, "BufferInactiveIcon"      ,{ fg = nil      , bg = "#383a4c", italic = false, bold = false, underline = false })
  hl(0, "BufferInactive"          ,{ fg = "#988C99", bg = "#383a4c", italic = false, bold = false, underline = false })
  hl(0, "BufferInactiveTarget"    ,{ fg = "#FA2C77", bg = "#383a4c", italic = true , bold = true , underline = true  })
  hl(0, "BufferInactiveMod"       ,{ fg = "#988C99", bg = "#383a4c", italic = false, bold = false, underline = false })
  hl(0, "BufferInactiveSign"      ,{ fg = "#ec7279", bg = "#383a4c", italic = false, bold = false, underline = false })

  hl(0, "BufferVisible"           ,{ fg = "#99c794", bg = "#383a4c", italic = false, bold = false, underline = false })
  hl(0, "BufferVisibleMod"        ,{ fg = "#EFEAD8", bg = "#383a4c", italic = false, bold = false, underline = false })
  hl(0, "BufferVisibleSign"       ,{ fg = "#988C99", bg = "#383a4c", italic = false, bold = false, underline = false })
  hl(0, "BufferVisibleTarget"     ,{ fg = "#EFEAD8", bg = "#383a4c", italic = false, bold = false, underline = false })
  hl(0, "BufferVisibleIndex"      ,{ fg = "#988C99", bg = "#383a4c", italic = false, bold = false, underline = false })
  hl(0, "BufferVisibleIcon"       ,{ fg = nil      , bg = "#383a4c", italic = false, bold = false, underline = false })

  hl(0, "BufferTabLineSel"        ,{ fg = "#EFEAD8", bg = "#383a4c", italic = false, bold = false, underline = false })
  hl(0, "BufferTabLineFill"       ,{ fg = "#EFEAD8", bg = "#383a4c", italic = false, bold = false, underline = false })
  hl(0, "BufferTabPageFill"       ,{ fg = "#EFEAD8", bg = "#243440", italic = false, bold = false, underline = false }) ]]
end

return M
