local M = {
	'ray-x/lsp_signature.nvim',
	enabled = true,
	event = 'LspAttach',
	-- dependencies = { 'nvim-lspconfig' },
}

function M.config()
	require('lsp_signature').setup({
		bind 						= true,
		wrap            = true,
		floating_window = false,
		doc_lines       = 0,
		hint_enable     = true,
		hint_prefix     = '🐼 ',
		hint_scheme     = 'String',
		hi_parameter    = 'LspSignatureActiveParameter',
		handler_opts    = {
			border = 'rounded'
		}
	})
end

return M
