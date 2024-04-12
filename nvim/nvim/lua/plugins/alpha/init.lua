-- Copyright (c) 2023 Ratheesh <ratheeshreddy@gmail.com>
-- License: MIT

local M = {
	'goolord/alpha-nvim',
	enabled  = true,
	event    = { 'VimEnter' },
	dependencies = {
		{
			'nvim-tree/nvim-web-devicons',
			config = function ()
				require('nvim-web-devicons').setup()
			end
		},
	},
	config = function()
		local has_alpha, alpha = pcall(require, "alpha")
		if not has_alpha then return end

		local config = require("plugins.alpha.config").config
		alpha.setup(config)
	end,
}
return M
