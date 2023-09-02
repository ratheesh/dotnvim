-- Copyright (c) 2023 Ratheesh <ratheeshreddy@gmail.com>
-- Author: Ratheesh S
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of
-- this software and associated documentation files (the "Software"), to deal in
-- the Software without restriction, including without limitation the rights to
-- use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
-- the Software, and to permit persons to whom the Software is furnished to do so,
-- subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
-- FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
-- COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
-- IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
-- CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

return {
	-- buffers tab
	{
		'tomiis4/BufferTabs.nvim',
		enabled = false,
		dependencies = {
			'nvim-tree/nvim-web-devicons', -- optional
		},
		lazy = false,
		config = function()
			require('buffertabs').setup({
				-- config
			})
		end
	},
	{
		'winston0410/range-highlight.nvim',
		enabled = true,
		dependencies = {
			'winston0410/cmd-parser.nvim'
		},
		config = function()
		require('range-highlight').setup({})
		end
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "Neotree",
		keys = {
			{
				"<leader>fe",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").get_root() })
				end,
				desc = "Explorer NeoTree (root dir)",
			},
			{
				"<leader>fE",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
				end,
				desc = "Explorer NeoTree (cwd)",
			},
			{ "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
			{ "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
		},
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		init = function()
			if vim.fn.argc() == 1 then
				local stat = vim.loop.fs_stat(vim.fn.argv(0))
				if stat and stat.type == "directory" then
					require("neo-tree")
				end
			end
		end,
		opts = {
			sources = { "filesystem", "buffers", "git_status", "document_symbols" },
			open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
			filesystem = {
				bind_to_cwd = false,
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
			},
			window = {
				mappings = {
					["<space>"] = "none",
				},
			},
			default_component_configs = {
				indent = {
					with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
			},
		},
		config = function(_, opts)
			require("neo-tree").setup(opts)
			vim.api.nvim_create_autocmd("TermClose", {
				pattern = "*lazygit",
				callback = function()
					if package.loaded["neo-tree.sources.git_status"] then
						require("neo-tree.sources.git_status").refresh()
					end
				end,
			})
		end,
	},
	-- floating window title
	{
		"b0o/incline.nvim",
		event   = "BufReadPre",
		enabled = true,
		config  = function()
			local function get_diagnostic_label(props)
				local icons = { error = '', warn = '', info = '', hint = '󰌶', }
				local label = {}

				for severity, icon in pairs(icons) do
					local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
					if n > 0 then
						table.insert(label, { icon .. ' ' .. n .. ' ', group = 'DiagnosticSign' .. severity })
					end
				end
				if #label > 0 then
					table.insert(label, {'| '})
				end
				return label
			end

			require("incline").setup({
				window = { margin = { vertical = 0, horizontal = 3 } },
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					local icon, color = require("nvim-web-devicons").get_icon_color(filename)
					local modified = vim.api.nvim_buf_get_option(props.buf, "modified") and "bold,italic" or "bold"
					return {
						{ get_diagnostic_label(props) },
						{ icon, guifg = color }, { " " },
						{ filename, gui = modified },
					}
				end,
			})
		end,
	},
	-- auto-resize windows
	{
		"anuvyklack/windows.nvim",
		event = "WinNew",
		dependencies = {
			{ "anuvyklack/middleclass" },
			{ "anuvyklack/animation.nvim", enabled = false },
		},
		keys = { { "<leader>m", "<cmd>WindowsMaximize<cr>", desc = "Zoom" } },
		config = function()
			vim.o.winwidth = 5
			vim.o.equalalways = false
			require("windows").setup({
				animation = { enable = false, duration = 150 },
			})
		end,
	},
	-- right side scrollbar
	{
		'lewis6991/satellite.nvim',
		enabled = true,
		event = 'VeryLazy',
		config = function ()
			require('satellite').setup()
		end
	},

}
-- End of File
