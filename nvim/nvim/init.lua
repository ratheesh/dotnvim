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
-- End of File
