return {
	-- { 'navarasu/onedark.nvim' },
	{
		'kaiuri/nvim-juliana',
		enabled=false,
		config=function ()
			-- require('nvim-juliana').colors
		end
	},
	{
		"folke/neodev.nvim",
		enabled = false,
		event = 'VeryLazy',
		config = function ()
			require('neodev').setup()
		end
	},
	{ 'mattn/emmet-vim', ft = { 'html', 'css', 'scss', 'xml' } },
	{ "williamboman/mason-lspconfig.nvim", event = 'LspAttach' },
	{ "tpope/vim-repeat", keys = "." },
	{
		'winston0410/range-highlight.nvim',
		enabled = false,
		event = { 'CmdlineEnter' },
		config=function ()
			require("range-highlight").setup()
		end,
		dependencies = { "winston0410/cmd-parser.nvim"  }
	},
	{
		'hood/popui.nvim',
		disable = false,
		config = function()
			vim.ui.select = require('popui.ui-overrider')
			vim.ui.input = require('popui.input-overrider')
		end
	},
	-- "rlch/github-notifications.nvim",
	{ 'psliwka/vim-smoothie', keys = { '<c-u>', '<c-d>' }},
	{ "folke/neoconf.nvim", enabled = false, cmd = "Neoconf" },
	{
		"lukas-reineke/virt-column.nvim",
		enabled = true,
		event   = 'VeryLazy',
		config = function ()
			require("virt-column").setup({char = '▕', virtcolumn = '+1'})
		end
	},
	{
		'xiyaowong/virtcolumn.nvim',
		enabled = false,
		event = 'BufReadPost',
		config = function ()
			vim.g.virtcolumn_char = '▕'
			vim.g.virtcolumn_priority = 10
		end
	},
	{
		'NvChad/nvim-colorizer.lua',
		event = 'VeryLazy',
		config = function ()
			require('colorizer').setup({
				filetypes = { "*" },
				user_default_options = {
					names = false,
					tailwind = "both",
					mode = "background"
				}
			})
		end,
	},
	-- { "EdenEast/nightfox.nvim", event = "VeryLazy" },
	{
		"mbbill/undotree",
		cmd = { "UndotreeShow", "UndotreeToggle", "UndotreeHide", "UndotreeFocus" },
	},
	{
		'tzachar/highlight-undo.nvim',
		enabled = true,
		event = 'BufReadPre',
		opts = {
				duration = 300,
				undo = {
					hlgroup = 'HighlightUndo',
					mode = 'n',
					lhs = 'u',
					map = 'undo',
					opts = {}
				},
				redo = {
					hlgroup = 'HighlightRedo',
					mode = 'n',
					lhs = '<C-r>',
					map = 'redo',
					opts = {}
				},
		}
	},
	{
		'echasnovski/mini.indentscope',
		event = 'LspAttach',
		config = function()
			require('mini.indentscope').setup({
				symbol = '╎',
			})
		end,
	},
	{
		"smjonas/inc-rename.nvim",
		enabled =  false,
		cmd = "IncRename",
		config = function()
			require("inc_rename").setup()
		end,
	},
	{
		"ojroques/vim-oscyank",
		cmd = { "OSCYank", "OSCYankReg" },
	},
	{
		'gbprod/yanky.nvim',
		enabled=true,
		cmd = { 'YankyCycleForward', 'YankyRingHistory' },
		keys = { 'yy', "Y" },
		opts = {
			ring = {
				history_length = 100,
				storage        = "shada",
				cancel_event   = "update",
				sync_with_numbered_registers = true,
			},
			system_clipboard = {
				sync_with_ring = true,
			},
			highlight = {
				on_put  = true,
				on_yank = true,
				timer   = 500,
			},
		},
		keys = {
			vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)"),
			vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")
		}
	},
	{
		'Bekaboo/dropbar.nvim',
		enabled = true,
		event = { 'VimEnter' },
		opts = {}
	},
	-- { "NvChad/nvim-colorizer.lua", ft = { "css" } },
	{ "stevearc/dressing.nvim", event = "VeryLazy" },
	{
		"ThePrimeagen/refactoring.nvim",
		init = function()
			-- prompt for a refactor to apply when the remap is triggered
			vim.keymap.set("v", "<leader>r", function()
				require("refactoring").select_refactor()
			end, { noremap = true, silent = true, expr = false })
		end,
		config = function()
			require("refactoring").setup({})
		end,
	},
	{
		'ckolkey/ts-node-action',
		enabled =  true,
		dependencies = { 'nvim-treesitter' },
		config = function()
			require("ts-node-action").setup({})
			vim.keymap.set({ "n" }, "<bs>", require("ts-node-action").node_action, { desc = "Trigger Node Action" })
		end
	},
	{
		"simrat39/symbols-outline.nvim",
		enabled = true,
		cmd = "SymbolsOutline",
		init = function()
			vim.keymap.set("n", "<leader>cs", "<cmd>SymbolsOutline<cr>", { desc = "Symbols Outline" })
		end,
		config = function()
			require("symbols-outline").setup()
		end,
	},
	{
		"m-demare/hlargs.nvim",
		event = "VeryLazy",
		enabled = false,
		config = function()
			require("hlargs").setup({
				excluded_argnames = {
					usages = {
						lua = { "self", "use" },
					},
				},
			})
		end,
	},
	{
		"LeonHeidelbach/trailblazer.nvim",
		enabled = false,
		event = 'VeryLazy',
		config = function()
			require("trailblazer").setup({
				-- your custom config goes here
			})
		end,
	},
	{
		"cshuaimin/ssr.nvim",
		enabled = true,
		keys = { '<space>cR' },
		init = function()
			vim.keymap.set({ "n", "x" }, "<leader>cR", function()
				require("ssr").open()
			end, { desc = "Structural Replace" })
		end,
	},
	{
		'kylechui/nvim-surround',
		event = 'VeryLazy',
		keys = { n = { 'ds', 'cs' }, x = { 'S' } },
		config = function ()
			require('nvim-surround').setup({
				highlight = {
					duration = 300,
				}
			})
		end
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPre",
		config = function()
			require("treesitter-context").setup()
		end,
	},
	{
		"andymass/vim-matchup",
		event = "BufReadPost",
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
	{
		'lewis6991/hover.nvim',
		enabled = true,
		event = 'LspAttach',
		require = 'nvim-lspconfig',
		config = function()
			require('hover').setup {
				init = function()
					-- Require providers
					require('hover.providers.lsp')
					require('hover.providers.man')
					require('hover.providers.gh')
					require('hover.providers.dictionary')
					-- require('hover.providers.LspAttach')
					-- require('hover.providers.css')
				end,
				preview_opts = {
					border = 'rounded',
				},
				title = true
			}
			vim.keymap.set('n', 'K', require('hover').hover, { desc = 'hover.nvim' })
			vim.keymap.set("n", "gK", require("hover").hover_select, {desc = "hover.nvim (select)"})
		end
	},
	{
		"dstein64/vim-startuptime",
		enabled = false,
		cmd = "StartupTime",
		config = function()
			vim.g.startuptime_tries = 10
		end,
	},
	{
		'asiryk/auto-hlsearch.nvim',
		enabled = false,
		opts = {
			remap_keys = { "/", "?", "*", "#", "n", "N" },
		}
	},
	{
		'echasnovski/mini.align',
		enabled = false,
		opts = {}
	},
	{
		'junegunn/vim-easy-align',
		enabled = true,
		event   = "VeryLazy",
		config  = function ()
			vim.cmd([[
			xmap ga <Plug>(EasyAlign)
			nmap ga <Plug>(EasyAlign)
			]])
		end
	},
	{
		'dhruvasagar/vim-table-mode',
		cmd = { 'TableModeToggle' , 'TableModeEnable', 'TableModeDisable', 'TableModeRealign' },
		config = function ()
			vim.g.table_mode_corner_corner   = '+'
			vim.g.table_mode_header_fillchar = '='
			vim.b.table_mode_corner          = '+'
		end
	},
	{
		'antoyo/vim-licenses',
		cmd = { 'Gplv2', 'Apache', 'Mit' },
		config = function ()
			vim.g.licenses_copyright_holders_name = 'Ratheesh <ratheeshreddy@gmail.com>'
			vim.g.licenses_authors_name           = 'Ratheesh S'
			vim.g.licenses_default_commands       = { 'Gplv2', 'Apache', 'Mit' }
		end
	},
	{
		'lewis6991/spaceless.nvim',
		enabled=false,
		event = 'VeryLazy',
		config = function()
			require('spaceless').setup()
		end
	},
	{
		'echasnovski/mini.move',
		enabled = true,
		opts = {}
	},
	{
		'romgrk/kirby.nvim',
		enabled = false,
		dependencies = {
			{ 'romgrk/fzy-lua-native', build = 'make install' },
			{ 'romgrk/kui.nvim' },
		},
	},
	{
		'tamton-aquib/flirt.nvim',
		enabled = false,
		event = 'VeryLazy',
		opts = {}
	},
	{
		'IMOKURI/line-number-interval.nvim',
		enabled = true,
		event = 'BufReadPost',
		config = function()
			vim.g.line_number_interval_enable_at_startup=1
			vim.g.line_number_interval=5
			vim.cmd([[LineNumberIntervalEnable]])
		end
	}
}
-- End of File
