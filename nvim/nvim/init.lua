-- Copyright (c) 2023 Ratheesh <ratheeshreddy@gmail.com>
-- License: MIT
-- Neovim bootstraping

-- vim.opt.rtp:append(vim.fn.stdpath "config" .. "/config")

vim.g.mapleader        = " "
require("config/lazy_bootstrap")

require("config.settings")
require("config.colors")
require("config.autocmds")
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		require("config.keymaps")
		require("config.commands")
	end,
})

local hl = vim.api.nvim_set_hl
hl(0, "BufferCurrent"           ,{ fg = "#e5d8bd", bg = "#4C5D79", italic = true,  bold = false, underline = false })
hl(0, "BufferCurrentNumber"     ,{ fg = "#F388AF", bg = "#4C5D79", italic = true,  bold = true,  underline = false })
hl(0, "BufferCurrentIndex"      ,{ fg = "#F388AF", bg = "#4C5D79", italic = false, bold = false, underline = false })
hl(0, "BufferCurrentIcon"       ,{ fg = nil      , bg = "#4C5D79", italic = false, bold = false, underline = false })
hl(0, "BufferDefaultCurrentIcon",{ fg = nil      , bg = "#4C5D79", italic = false, bold = false, underline = false })
hl(0, "BufferCurrentMod"        ,{ fg = "#e5d8bd", bg = "#4C5D79", italic = true,  bold = false, underline = false })
hl(0, "BufferCurrentTarget"     ,{ fg = "#FA2C77", bg = "#4C5D79", italic = true , bold = true , underline = true  })
hl(0, "BufferCurrentSign"       ,{ fg = "#4C5D79", bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferCurrentERROR"      ,{ fg = "#FA2C77", bg = "#4C5D79", italic = false, bold = false, underline = false })
hl(0, "BufferCurrentHINT"       ,{ fg = nil      , bg = "#4C5D79", italic = false, bold = false, underline = false })
hl(0, "BufferCurrentINFO"       ,{ fg = nil      , bg = "#4C5D79", italic = false, bold = false, underline = false })

hl(0, "BufferInActive"          ,{ fg = "#99c794", bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferInactiveIndex"     ,{ fg = "#988C99", bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferInactiveIcon"      ,{ fg = nil      , bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferInactive"          ,{ fg = "#988C99", bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferInactiveTarget"    ,{ fg = "#FA2C77", bg = "#243440", italic = true , bold = true , underline = true  })
hl(0, "BufferInactiveMod"       ,{ fg = "#988C99", bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferInactiveSign"      ,{ fg = "#4C5D79", bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferInactiveERROR"     ,{ fg = "#FA2C77", bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferInactiveHINT"      ,{ fg = nil      , bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferInactiveINFO"      ,{ fg = nil      , bg = "#243440", italic = false, bold = false, underline = false })

hl(0, "BufferVisible"           ,{ fg = "#99c794", bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferVisibleMod"        ,{ fg = "#EFEAD8", bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferVisibleSign"       ,{ fg = "#988C99", bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferVisibleTarget"     ,{ fg = "#EFEAD8", bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferVisibleIndex"      ,{ fg = "#988C99", bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferVisibleIcon"       ,{ fg = nil      , bg = "#243440", italic = false, bold = false, underline = false })

hl(0, "BufferTabLineSel"        ,{ fg = "#EFEAD8", bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferTabLineFill"       ,{ fg = "#EFEAD8", bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferTabPageFill"       ,{ fg = "#EFEAD8", bg = "#243440", italic = false, bold = false, underline = false })

-- End of File
