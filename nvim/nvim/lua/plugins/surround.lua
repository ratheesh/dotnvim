local M = {
	'kylechui/nvim-surround',
	enabled = true,
	keys = { n = { 'ds', 'cs' }, v = { 'S' } }
}

function M.config()
	require('nvim-surround').setup({
		highlight = {
			duration = 300,
		}
	})
end

return M
