local M = {}

M.signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

function M.setup()
	-- Automatically update diagnostics
	vim.diagnostic.config({
		underline        = true,
		update_in_insert = false,
		virtual_text     = false,
		severity_sort    = true,
		float = {
			border    = 'rounded',
			focusable = false,
		},
	})

  vim.lsp.handlers["workspace/diagnostic/refresh"] = function(_, _, ctx)
    local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
    pcall(vim.diagnostic.reset, ns)
    return true
  end

  for type, icon in pairs(M.signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end
end

require('lspconfig.ui.windows').default_options = {
	border = "rounded"
}

return M
