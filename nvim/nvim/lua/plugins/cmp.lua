local M = {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lua",
		"L3MON4D3/LuaSnip",
		"onsails/lspkind-nvim",

	},
}

function M.config()
	local cmp = require("cmp")
	local lspkind = require("lspkind")
	local cmp     = require('cmp')
	local types   = require('cmp.types')
	local luasnip = require('luasnip')

	local function check_backspace()
		local col = vim.fn.col '.' - 1
		return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
	end

	local feedkeys = vim.fn.feedkeys
	local replace_termcodes = vim.api.nvim_replace_termcodes
	local backspace_keys = replace_termcodes('<tab>', true, true, true)
	local snippet_next_keys = replace_termcodes('<plug>luasnip-expand-or-jump', true, true, true)
	local snippet_prev_keys = replace_termcodes('<plug>luasnip-jump-prev', true, true, true)
	local mapping = cmp.mapping

	local has_words_before = function()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
	end

	local icons = {
		Text     = ' ' , Method = ' ' , Function  = ' ' , Constructor = ' ' , Field         = ' ' ,
		Variable = ' ' , Class  = ' ' , Interface = ' ' , Module      = ' ' , Property      = ' ' ,
		Unit     = ' ' , Value  = ' ' , Enum      = ' ' , Keyword     = ' ' , Snippet       = ' ' ,
		color    = ' ' , File   = ' ' , Reference = ' ' , Folder      = ' ' , Enummember    = ' ' ,
		Constant = ' ' , Struct = 'פּ ' , Event     = ' ' , Operator    = ' ' , Typeparameter = ' ' ,

		--[[ Text     = '',  Method = '', Function  = '', Constructor = '', Field         = 'ﰠ',
		Variable = '',  Class  = 'ﴯ', Interface = '', Module      = '', Property      = 'ﰠ',
		Unit     = '塞', Value  = '', Enum      = '', Keyword     = '', Snippet       = '',
		Color    = '',  File   = '', Reference = '', Folder      = '', EnumMember    = '',
		Constant = '',  Struct = 'פּ', Event     = '', Operator    = '', TypeParameter = '', ]]
	}

	cmp.setup({
		window = {
			completion    = cmp.config.window.bordered({
				winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
				scrollbar = false,
			}),
			documentation = cmp.config.window.bordered({ winhighlight = 'Normal:CmpDocNormal' }),
		},
		view = {
			entries = "custom", -- can be "custom", "wildmenu" or "native"
			winhighlight = 'Normal:WildStatus,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
		},
		sources = {
			-- { name = 'nvim_lsp_signature_help' },
			{ name = 'nvim_lsp' },
			{ name = 'nvim_lua' },
			{ name = 'path'     },
			{ name = 'luasnip'  },
			{
				name = 'buffer',
				option = {
					get_bufnrs = function()
						local bufs = {}
						for _, win in ipairs(vim.api.nvim_list_wins()) do
							bufs[vim.api.nvim_win_get_buf(win)] = true
						end
						return vim.tbl_keys(bufs)
					end
				},
			},
			{ name = 'conventionalcommits' },
		},
		experimental = {
			ghost_text = { hl_group = 'CmpGhostText' }
		},
		performance = {
			trigger_debounce_time = 100
		},
		snippet = {
			expand = function(args) require('luasnip').lsp_expand(args.body) end,
		},
		--[[ sorting = {
			comparators = {
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.recently_used,
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			},
		}, ]]
		formatting = {
			fields = { 'kind', 'abbr', 'menu'},
			format = require('lspkind').cmp_format({
				preset        = 'codicons',
				ellipsis_char = '...',
				mode          = 'symbol',
				symbol_map    = icons,
				maxwidth      = 60,
				before = function (entry, vim_item)
					vim_item.menu = ({
						luasnip     = 'SNP',
						nvim_lsp    = 'LSP',
						nvim_lua    = 'NVM',
						buffer      = 'BUF',
						path        = 'PATH',
						cmp_tabnine = 'T9',
					})[entry.source.name]
					return vim_item
				end
			})
		},
		mapping = {
			['<C-n>']     = mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Insert }),
			['<C-p>']     = mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert }),
			['<C-u>']     = mapping(mapping.scroll_docs(-4), { 'i' }),
			['<C-d>']     = mapping(mapping.scroll_docs(4),  { 'i' }),
			['<C-Space>'] = mapping.complete(),
			-- ['<C-e>']     = mapping.abort(),
			['<C-y>']     = mapping.confirm({ select = true }),
			['<CR>']      = mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
			['<Tab>'] 		= mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					feedkeys(snippet_next_keys, '')
				elseif check_backspace() then
					feedkeys(backspace_keys, 'n')
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, { 'i', 's' }),

			['<S-Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					feedkeys(snippet_prev_keys, '')
				else
					fallback()
				end
			end, { 'i', 's' }),
		}
	})
end

return M
