local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

M.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

M.setup = function()
	vim.diagnostic.config({
		virtual_text = false,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
		signs = true,
		underline = true,
		update_in_insert = true,
		severity_sort = false,
	})

	---- sign column
	local signs = require("utils").lsp_signs

	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true }

	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", bufopts)
	vim.keymap.set("n", "<leader>gr", "<cmd>Telescope lsp_references<cr>", bufopts)
	vim.keymap.set("n", "<leader>gi", "<cmd>Telescope lsp_implementations<cr>", bufopts)
	vim.keymap.set("n", "<leader>gt", "<cmd>Telescope lsp_type_definitions<cr>", bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	-- vim.keymap.set("n", "k", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
	-- show diagnostics in hover window
	vim.api.nvim_create_autocmd("CursorHold", {
		callback = function()
			local opts = {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter" },
				border = "rounded",
				source = "always",
				prefix = " ",
				scope = "cursor",
			}
			vim.diagnostic.open_float(nil, opts)
		end,
	})
end

M.on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	if client.server_capabilities.definitionProvider then
		vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
	end

	local lsp_signature_cfg = {
		bind 			= true,
		wrap            = true,
		floating_window = false,
		doc_lines       = 3,
		hint_enable     = true,
		hint_prefix     = '🐼 ',
		hint_inline     = function() return false end,
		hint_scheme     = 'String',
		hi_parameter    = 'LspSignatureActiveParameter',
		always_trigger  = true,
		handler_opts    = {
			border = 'rounded'
		}
	}
	require('lsp_signature').on_attach(lsp_signature_cfg, bufnr)

	if vim.lsp.inlay_hint then
		if client.server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint(bufnr, true)
		end
	end

    client.server_capabilities.semanticTokensProvider = nil
    -- Hide semantic highlights for functions
    vim.api.nvim_set_hl(0, '@lsp.type.function', {})
end

return M
