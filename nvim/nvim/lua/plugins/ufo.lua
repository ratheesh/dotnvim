-- Copyright (c) 2023 Ratheesh <ratheeshreddy@gmail.com>
-- License: MIT
-- UFO plugin config

local M = {
	"kevinhwang91/nvim-ufo",
	requires = {
		"kevinhwang91/promise-async",
		{
			"luukvbaal/statuscol.nvim",
			config = function()
				require("statuscol").setup(
				{
					foldfunc = "builtin",
					setopt = true
				}
				)
			end
		}
	}
}

function M.config()
	vim.o.foldcolumn = "1" -- '0' is not bad
	vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
	vim.o.foldlevelstart = 99
	vim.o.foldenable = true
	vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

	-- these are "extra", change them as you like
	vim.keymap.set("n", "zR", require("ufo").openAllFolds)
	vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

	-- Option 3: treesitter as a main provider instead
	-- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
	-- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
	require("ufo").setup(
	{
		provider_selector = function(_, _, _)
			return {"treesitter", "indent"}
		end
	}
	)
end

return M
