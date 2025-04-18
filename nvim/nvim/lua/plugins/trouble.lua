return {
	"folke/trouble.nvim",
	enabled = true,
	cmd = { "Trouble", "Trouble" },
	opts = {
		use_diagnostic_signs = true,
		auto_open    = false,
		auto_close   = true,
		padding      = false,
		height       = 5,
		signs        = { error = '', warning = '', hint = '󰌶', information = '', other = '', },
		track_cursor = true,

		action_keys = {
			close          = 'q',
			cancel         = '<esc>',
			refresh        = 'r',
			jump           = { '<cr>', '<tab>' },
			jump_close     = { 'o' },
			toggle_mode    = 'm',
			toggle_preview = 'P',
			hover          = 'K',
			preview        = 'p',
			close_folds    = { 'zM', 'zm' },
			open_folds     = { 'zR', 'zr' },
			toggle_fold    = { 'zA', 'za' },
			previous       = 'k',
			next           = 'j'
		},
	},
	keys = {
		{ "gR", "<cmd>Trouble lsp_references toggle<cr>", desc = "Toggle LSP References (Trouble)" },
		{ "gd", "<cmd>Trouble lsp_declarations<cr>", desc = "LSP Definition (Trouble)" },
		{ "gD", "<cmd>Trouble lsp_definitions<cr>", desc = "LSP Definition (Trouble)" },
		{ "<F3>", "<cmd>Trouble diagnostics toggle<cr>", desc = "Toggle Trouble diagnostics" },
		{
			"[q",
			function()
				if require("trouble").is_open() then
					require("trouble").previous({ skip_groups = true, jump = true })
				else
					local ok, err = pcall(vim.cmd.cprev)
					if not ok then
						vim.notify(err, vim.log.levels.ERROR)
					end
				end
			end,
			desc = "Previous trouble/quickfix item",
		},
		{
			"]q",
			function()
				if require("trouble").is_open() then
					require("trouble").next({ skip_groups = true, jump = true })
				else
					local ok, err = pcall(vim.cmd.cnext)
					if not ok then
						vim.notify(err, vim.log.levels.ERROR)
					end
				end
			end,
			desc = "Next trouble/quickfix item",
		},
	},
}
-- End of File
