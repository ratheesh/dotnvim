local M = {
  "nvim-treesitter/nvim-treesitter",
  dev = false,
  build = ":TSUpdate",
  event = "VeryLazy",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    -- "RRethy/nvim-treesitter-textsubjects",
    -- "nvim-treesitter/nvim-treesitter-refactor",
    -- "mfussenegger/nvim-treehopper",
		-- { 'mrjones2014/nvim-ts-rainbow', event = 'LspAttach' },
		-- { 'HiPhish/nvim-ts-rainbow2', event = 'LspAttach' },
		{
			'HiPhish/rainbow-delimiters.nvim',
			config = function()
				local rainbow_delimiters = require('rainbow-delimiters')
				vim.g.rainbow_delimiters = {
					strategy = {
						[''] = rainbow_delimiters.strategy['global'],
						vim = rainbow_delimiters.strategy['local'],
					},
					query = {
						[''] = 'rainbow-delimiters',
						lua = 'rainbow-blocks',
					},
					highlight = {
						'rainbowcol1',
						'rainbowcol2',
						'rainbowcol3',
						'rainbowcol4',
						'rainbowcol5',
						'rainbowcol6',
						'rainbowcol7',
					},
				}
			end
		},
		{ 'RRethy/nvim-treesitter-endwise', event = 'InsertEnter', pin = true },
		{ 'nvim-lua/plenary.nvim' },
		-- { 'David-Kunz/markid' }
    -- { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
  },
}

function M.init()
  --vim.cmd([[
  --  omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>
  --  xnoremap <silent> m :lua require('tsht').nodes()<CR>
  --]])
end

function M.config()
  require("nvim-treesitter.configs").setup({
		highlight = {
			enable = false,
			additional_vim_regex_highlighting = false,
		},
		ensure_installed = {
			"bash", "c", "cpp", "css", "html", "java", "javascript", "json",
			"lua","python", "regex", "vim", "yaml", "norg", "vue", "htmldjango",
      "markdown", "markdown_inline",
		},
		indent    = { enable = false },
		matchup   = { enable = true  },
		autopairs = { enable = true  },
		autotag   = { enable = false },
		endwise   = { enable = true  },
		textsubjects = {
			enable         = true,
			prev_selection = ',',
			keymaps  = {
				['.']  = 'textsubjects-smart',
				[';']  = 'textsubjects-container-outer',
				['i;'] = 'textsubjects-container-inner',
			},
		},
    query_linter = {
      enable = false,
      use_virtual_text = true,
      lint_events = { "BufWrite", "CursorHold" },
    },
	textobjects = {
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection    = '<CR>',
				scope_incremental = '<CR>',
				node_incremental  = '<TAB>',
				node_decremental  = '<S-TAB>',
			},
		},
		select = {
			enable    = true,
			lookahead = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				['al'] = '@loop.outer',
				['il'] = '@loop.inner',
				['aa'] = '@parameter.outer',
				['ia'] = '@parameter.inner',
				['uc'] = '@comment.outer',
			},
			selection_modes = {
				['@function.outer']   = 'V',
				['@sparameter.outer'] = 'v',
				['@class.outer']      = '<c-v>',
			},
		},
		swap = {
			enable = false,
			swap_next = {
				["ap"] = "@parameter.inner",
			},
			swap_previous = {
				-- ["an"] = "@parameter.inner",
			},
		},
	},
	markid = { enable = true },
		--[[ rainbow   = {
			enable         = false,
			extended_mode  = true,
			max_file_lines = 2000,
			query = 'rainbow-parens',
			strategy = require 'ts-rainbow.strategy.global',
			hlgroups = {
				'rainbowcol1',
				'rainbowcol2',
				'rainbowcol3',
				'rainbowcol4',
				'rainbowcol5',
				'rainbowcol6',
				'rainbowcol7',
			},
		}, ]]
  })
  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  parser_config.markdown.filetype_to_parsername = "octo"
end

return M
