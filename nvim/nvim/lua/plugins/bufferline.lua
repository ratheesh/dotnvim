
return {
  'akinsho/bufferline.nvim',
  enabled = true,
  event = 'VeryLazy',
  config = function()
    require('bufferline').setup({
      options = {
        always_show_bufferline = true,
        mode      = 'buffers',
        -- numbers   = 'ordinal',
        numbers = function(opts)
          local tmpid = opts.ordinal > 9 and 10 or opts.ordinal
          -- local icons = {"೧", "೨", "೩", "೪", "೫", "೬", "೭", "೮", "೯", "0"}
          -- local icons = {"೧", "೨", "೩", "೪", "೫", "೬", "೭", "೮", "೯", "0"}
          -- local icons = {"1", "2", "3", "4", "5", "6", "7", "8", "", ""}
          local icons={ "𝟏", "𝟐", "𝟑", "𝟒", "𝟓", "𝟔", "𝟕", "𝟖", "𝟗", "𝟎" }

          return icons[tmpid] --         
        end,
        indicator = {
          -- icon = '▌',
          style   = 'underline'
        },
        separator_style = 'none',
        buffer_close_icon = '',
        -- diagnostics       = 'nvim_lsp',
        diagnostics       = false,
        hover = {
          enabled = true,
          delay   = 0,
          reveal  = { 'close' },
        },
      },

      highlights = {
        fill = {
          fg = '#EFEAD8',
          bg = '#141414',
        },
        background = {
          bg = '#1E2430'
        },
        buffer = {
          fg = '#988C99',
          bg = '#1E2430'
        },
        buffer_visible = {
          fg = '#988C99',
          bg = '#1E2430'
        },
        buffer_selected = {
          fg = '#00BEFF',
          bg = '#1E2430',
          bold = true,
          italic = true,
        },
        close_button = {
          fg = '#988C99',
          bg = '#1E2430'
        },
        close_button_visible = {
          fg = '#988C99',
          bg = '#1E2430'
        },
        close_button_selected = {
          fg = '#da627d',
          bg = '#1E2430',
        },
        separator_selected = {
          fg = '#1E2430',
          bg = '#1E2430',
        },
        separator_visible = {
          fg = '#1E2430',
          bg = '#1E2430',
        },
        separator = {
          fg = '#1E2430',
          bg = '#1E2430'
        },
        indicator_visible = {
          fg = '#F7CAB8',
          bg = '#1E2430',
          bold = true,
        },
        indicator_selected = {
          fg = '#F7CAB8',
          bg = '#1E2430',
          sp = '#E23D75',
          bold = true,
          underdouble = true,
          underline = true,
        },
        pick_selected = {
          fg = '#cf314a',
          bg = '#1E2430',
          bold = true,
          italic = true,
        },
        pick_visible = {
          fg = '#cf314a',
          bg = '#1E2430',
          bold = true,
          italic = true,
        },
        pick = {
          fg = '#cf314a',
          bg = '#1E2430',
          bold = true,
          italic = true,
        },
        tab = {
          fg = '#988C99',
          bg = '#1E2430'
        },
        tab_selected = {
          fg = '#A3BE8C',
          bg = '#1E2430',
          sp = 'red',
          bold = true,
          -- underline = true,
          -- undercurl = true,
        },
        numbers = {
          bg = '#1E2430',
          bold = false,
        },
        numbers_visible = {
          bg = '#1E2430',
          bold = false,
        },
        numbers_selected = {
          fg = '#F2A490',
          bg = '#1E2430',
          italic = false,
          bold = false,
        },
        modified = {
          bg = '#1E2430'
        },
        modified_visible = {
          bg = '#1E2430'
        },
        modified_selected = {
          fg = '#E23D75',
          bg = '#1E2430',
        },
        duplicate_selected = {
          fg = '#99c794',
          bg = '#1E2430',
          bold = false,
          italic = true,
        },
        duplicate_visible = {
          bg = '#1E2430'
        },
        duplicate = {
          bg = '#1E2430'
        },
      }
    })

    local function map(mode, lhs, rhs, opts)
      local options = { noremap = true, silent = true }
      if opts then options = vim.tbl_extend('force', options, opts) end
      vim.api.nvim_set_keymap(mode, lhs, rhs, options)
    end

    -- Move to previous/next
    map('n', '<Leader>h', '<Cmd>BufferLineCyclePrev<CR>',    { desc = 'Goto Previous Buffer' })
    map('n', '<Leader>l', '<Cmd>BufferLineCycleNext<CR>',    { desc = 'Goto Next Buffer'     })

    -- Jump to buffer index
    map('n', '<Leader>1', '<Cmd>BufferLineGoToBuffer 1<CR>', { desc = 'Goto Buffer 1'        })
    map('n', '<Leader>2', '<Cmd>BufferLineGoToBuffer 2<CR>', { desc = 'Goto Buffer 2'        })
    map('n', '<Leader>3', '<Cmd>BufferLineGoToBuffer 3<CR>', { desc = 'Goto Buffer 3'        })
    map('n', '<Leader>4', '<Cmd>BufferLineGoToBuffer 4<CR>', { desc = 'Goto Buffer 4'        })
    map('n', '<Leader>5', '<Cmd>BufferLineGoToBuffer 5<CR>', { desc = 'Goto Buffer 5'        })
    map('n', '<Leader>6', '<Cmd>BufferLineGoToBuffer 6<CR>', { desc = 'Goto Buffer 6'        })
    map('n', '<Leader>7', '<Cmd>BufferLineGoToBuffer 7<CR>', { desc = 'Goto Buffer 7'        })
    map('n', '<Leader>8', '<Cmd>BufferLineGoToBuffer 8<CR>', { desc = 'Goto Buffer 8'        })
    map('n', '<Leader>9', '<Cmd>BufferLineGoToBuffer 9<CR>', { desc = 'Goto Buffer 9'        })

    map('n', '<A-p>',    '<Cmd>BufferLineTogglePin<CR>',     { desc = 'Pin Buffer'           })
    map('n', '<A-d>',    '<Cmd>bdelete<CR>',                 { desc = 'Delete Current Buf'   })
    map('n', '<C-s>',    '<Cmd>BufferLinePick<CR>',          { desc = 'Pick Buffer'          })
    map('n', '<A->>',    '<Cmd>BufferLineMoveNext<CR>',      { desc = 'Move Buffer Right'    })
    map('n', '<A-<>',    '<Cmd>BufferLineMovePrev<CR>',      { desc = 'Move Buffer Left'     })
    map('n' , '<C-j>',   '<Cmd>BufferLast<CR>',              { desc = "Previous Buffer"      })

  end
}

-- End of File
