local M = {
	"neovim/nvim-lspconfig",
	name = "lsp",
	event = "BufReadPre",
	ft = { 'c', 'cpp', 'python', 'java', 'lua',
	'html', 'javascript', 'vue', 'markdown', 'sh', 'css' },
	dependencies = {
		{ 'hrsh7th/cmp-nvim-lsp' },
		{ 'ray-x/lsp_signature.nvim', event = 'InsertEnter' },
		{
			'Issafalcon/lsp-overloads.nvim',
			event = 'InsertEnter'
		},
		{
			'mrshmllow/document-color.nvim',
			event   = 'LspAttach',
			config  = function ()
				require('document-color').setup({
					mode = 'background',
				})
			end
		},
		{
			'SmiteshP/nvim-navic',
			enabled = false,
		},
		{
			'dnlhc/glance.nvim',
			disable = false,
			event = 'LspAttach',
			config = function()
				require('glance').setup({
					border = {
						enable      = true,
						top_char    = '─',
						bottom_char = '─',
					},
				})
			end,
		},
		{
			"glepnir/lspsaga.nvim",
			enabled = false,
			event = "BufRead",
			config = function()
				require("lspsaga").setup({
					lightbulb = {
						enable           = false,
						enable_in_insert = true,
						sign             = true,
						sign_priority    = 40,
						virtual_text     = true,
					},
					symbol_in_winbar = {
						enable       = false,
						separator    = "->",
						hide_keyword = true,
						show_file    = true,
						folder_level = 2,
						respect_root = false,
						color_mode   = true,
					},
				})
			end,
			dependencies = { {"nvim-tree/nvim-web-devicons"} }
		}
	}
}

function M.config()
	require('plugins.lsp.pylance')
	require("mason")
	require("plugins.lsp.diagnostics").setup()

	local util = require("lspconfig/util")

	local function on_attach(client, bufnr)
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

		if client.server_capabilities.definitionProvider then
			vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
		end

		-- require("lsp-inlayhints").on_attach(client, bufnr)
		if vim.lsp.inlay_hint then
			if client.server_capabilities.inlayHintProvider then
				vim.lsp.inlay_hint(bufnr, true)
			end
		end

		client.server_capabilities.semanticTokensProvider = nil

		if client.server_capabilities.colorProvider then
			require("document-color").buf_attach(bufnr)
		end

		if client.server_capabilities.documentHighlightProvider then
			local group = vim.api.nvim_create_augroup("DocumentHighlight", {})
			vim.api.nvim_create_autocmd("CursorHold", {
				group = group,
				buffer = 0,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd("CursorMoved", {
				group = group,
				buffer = 0,
				callback = vim.lsp.buf.clear_references,
			})
		end

		if client.server_capabilities.documentSymbolProvider then
			require("nvim-navic").attach(client, bufnr)
		end

		-- require("plugins.lsp.formatting").setup(client, bufnr)
		require("plugins.lsp.keys").setup(client, bufnr)
	end

	---@type lspconfig.options
	local servers = {
		bashls = {},
		clangd = {
			cmd = { 'clangd', '--background-index', '--header-insertion=iwyu',
			'--completion-style=bundled', '--function-arg-placeholders', '--malloc-trim',
			'--pch-storage=memory', '--clang-tidy', '--header-insertion-decorators',
			'--all-scopes-completion', '--offset-encoding=utf-16', '--inlay-hints=true'
		},
		flags = {
			debounce_text_changes = 150,
		};
		init_options = {
			clangdFileStatus     = true,
			usePlaceholders      = true,
			completeUnimported   = true,
			semanticHighlighting = true,
			InlayHints = {
				Enabled        = true,
				ParameterNames = true,
				DeducedTypes   = true,
			},
		};
	},

	-- Web Dev
	cssls = {},
	cssmodules_ls = {},
	-- tailwindcss = {},
	emmet_ls = {},
	yamlls = {},
	eslint = {},
	html = {
		settings = {
			html = {
				format = {
					templating     = true,
					wrapLineLength = 120,
					wrapAttributes = 'auto',
				},
				hover = {
					documentation = true,
					references    = true,
				},
			},
		},
	},

	-- python
	-- pyright = {},
	jedi_language_server = {},
	-- ruff_lsp={},
	pylyzer = {},
	-- pylance = {},
	tsserver = {},

	-- lua
	lua_ls = {
		single_file_support = true,
		settings = {
			Lua = {
				workspace = {
					checkThirdParty = false,
				},
				completion = {
					workspaceWord = true,
					callSnippet = "Replace",
				},
				misc = {
					parameters = {
						"--log-level=trace",
					},
				},
				hint = {
					enable = true,
				},
				diagnostics = {
					-- enable = false,
					globals = { 'vim' },
					disable = {
						"missing-parameter",
						"cast-local-type",
						"param-type-mismatch",
						"assign-type-mismatch",
						"undefined-field",
						"redundant-parameter",
						"no-unknown"
					},
					groupSeverity = {
						strong = "Warning",
						strict = "Warning",
					},
					groupFileStatus = {
						["ambiguity"]  = "Opened",
						["await"]      = "Opened",
						["codestyle"]  = "None",
						["duplicate"]  = "Opened",
						["global"]     = "Opened",
						["luadoc"]     = "Opened",
						["redefined"]  = "Opened",
						["strict"]     = "Opened",
						["strong"]     = "Opened",
						["type-check"] = "Opened",
						["unbalanced"] = "Opened",
						["unused"]     = "Opened",
					},
					unusedLocalExclude = { "_*" },
				},
				format = {
					enable = false,
					defaultConfig = {
						indent_style = "space",
						indent_size  = "2",
						continuation_indent_size = "2",
					},
				},
			},
		},
	},

	vimls = {},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

local win = require("lspconfig.ui.windows")
local _default_opts = win.default_opts
win.default_opts = function(options)
	local opts = _default_opts(options)
	opts.border = "rounded"
	return opts
end

---@type _.lspconfig.options
local options = {
	debug             = false,
	debounce          = 150,
	save_after_format = false,
	on_init = function(new_client, _)
		new_client.offset_encoding = 'utf-16'
	end,
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 150,
	},
}

for server, opts in pairs(servers) do
	opts = vim.tbl_deep_extend("force", {}, options, opts or {})
	require("lspconfig")[server].setup(opts)
end

require("plugins.null-ls").setup(options)
end

return M
