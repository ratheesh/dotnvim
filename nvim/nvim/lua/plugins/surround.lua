local M = {
	'kylechui/nvim-surround',
	disable = false,
}

function M.config()
	require('nvim-surround').setup({
		highlight = {
			duration = 300,
		}
	})
end

return M
