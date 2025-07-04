local M = {
	'windwp/windline.nvim',
	enabled = true,
	event = 'VeryLazy'
}

function M.config()
local windline = require('windline')
local helper   = require('windline.helpers')
local sep      = helper.separators
local Hydra    = require("hydra.statusline")
local animation = require('wlanimation')
local efffects = require('wlanimation.effects')

local b_components = require('windline.components.basic')
local state = _G.WindLine.state

local luffy_text = ""
local lsp_comps = require('windline.components.lsp')
local git_comps = require('windline.components.git')

local hl_list = {
	Black    = { 'white'      , 'black'      },
	White    = { 'black'      , 'white'      },
	Inactive = { 'InactiveFg' , 'InactiveBg' },
	Active   = { 'ActiveFg'   , 'ActiveBg'   },

	-- Left Space
	LeftSpace = { 'ActiveFg', 'ActiveBg' },

	StatusLine  = {'StatusLine'  , 'ActiveBg' },

	-- Mode
	ModeNormal  = {'ModeNormalFg'  , 'ModeNormalBg', 'bold'  },
	ModeInsert  = {'ModeInsertFg'  , 'ModeInsertBg' , 'bold' },
	ModeVisual  = {'ModeVisualFg'  , 'ModeVisualBg' , 'bold' },
	ModeReplace = {'ModeReplaceFg' , 'ModeReplaceBg' , 'bold'},
	ModeCommand = {'ModeCommandFg' , 'ModeCommandBg' , 'bold'},

	-- File
	File      = { 'FileNameBg',  'ActiveBg',     'italic' },
	FileIcon  = { 'FileNameFg',  'FileNameBg' },
	SearchCnt = { 'SearchCntFg', 'FileNameBg' },

	-- Navic     = { 'NavicBg', 'ActiveBg' },

	-- Git status
	GitDiffAdded   = { 'GitAddedFg',   'FileNameBg' },
	GitDiffRemoved = { 'GitRemovedFg', 'FileNameBg' },
	GitDiffChanged = { 'GitChangedFg', 'FileNameBg' },

-- spell right sep
	PasteRightProjSep = { 'PasteModeBg', 'NormalBg' },
	PasteRightFileSep = { 'PasteModeBg', 'NormalBg' },
}

-- local hide_in_width = function() return vim.fn.winwidth(0) > 90 end

local basic = {}

basic.divider = { b_components.divider, '' }
basic.space   = { ' ', '' }
basic.bg      = { ' ', 'StatusLine' }
basic.file_name_inactive = { b_components.full_file_name, hl_list.Inactive }
basic.line_col_inactive  = { b_components.line_col, hl_list.Inactive }
basic.progress_inactive  = { b_components.progress, hl_list.Inactive }

basic.vi_mode = {
	name = 'vi_mode',
	hl_colors = {
		Normal        = hl_list.ModeNormal,
		Insert        = hl_list.ModeInsert,
		Visual        = hl_list.ModeVisual,
		Replace       = hl_list.ModeReplace,
		Command       = hl_list.ModeCommand,
		NormalBefore  = { 'ModeNormalBg' , 'ActiveBg' , 'bold' },
		InsertBefore  = { 'ModeInsertBg' , 'ActiveBg' , 'bold' },
		VisualBefore  = { 'ModeVisualBg' , 'ActiveBg' , 'bold' },
		ReplaceBefore = { 'ModeReplaceBg', 'ActiveBg' , 'bold' },
		CommandBefore = { 'ModeCommandBg', 'ActiveBg' , 'bold' },
		NormalAfter   = { 'FileNameBg'   , 'ModeNormalBg' , 'bold' },
		InsertAfter   = { 'FileNameBg'   , 'ModeInsertBg' , 'bold' },
		VisualAfter   = { 'FileNameBg'   , 'ModeVisualBg' , 'bold' },
		ReplaceAfter  = { 'FileNameBg'   , 'ModeReplaceBg' , 'bold' },
		CommandAfter  = { 'FileNameBg'   , 'ModeCommandBg' , 'bold' },
	},

	text = function()
		if Hydra.is_active() then
			return {
				{ '󰫍─', hl_list.StatusLine },
				{ sep.left_rounded, state.mode[2] .. 'Before' },
				{ ' ' ..  Hydra.get_name() .. ' ', state.mode[2] },
			}
		else
			return {
				{ '󰫍─', hl_list.StatusLine },
				{ sep.left_rounded, state.mode[2] .. 'Before' },
				{ luffy_text..' '..state.mode[1], state.mode[2] },
				-- { sep.left_rounded, state.mode[2] .. 'After' },
			}
		end
	end,
}

basic.mode_rightsep = {
	hl_colors = {
		default  			= { 'FileNameFg'    , 'FileNameBg'    },
		sep_left 			= { 'ProjectNameBg' , 'FileNameBg'    },
		FileNormalAfter     = { 'FileNameBg'    , 'ModeNormalBg'  },
		FileInsertAfter     = { 'FileNameBg'    , 'ModeInsertBg'  },
		FileVisualAfter     = { 'FileNameBg'    , 'ModeVisualBg'  },
		FileReplaceAfter    = { 'FileNameBg'    , 'ModeReplaceBg' },
		FileCommandAfter    = { 'FileNameBg'    , 'ModeCommandBg' },
		PasteNormalAfter    = { 'PasteModeBg'   , 'ModeNormalBg'  },
		PasteInsertAfter    = { 'PasteModeBg'   , 'ModeInsertBg'  },
		PasteVisualAfter    = { 'PasteModeBg'   , 'ModeVisualBg'  },
		PasteReplaceAfter   = { 'PasteModeBg'   , 'ModeReplaceBg' },
		PasteCommandAfter   = { 'PasteModeBg'   , 'ModeCommandBg' },
		ProjectNormalAfter  = { 'ProjectNameBg' , 'ModeNormalBg'  },
		ProjectInsertAfter  = { 'ProjectNameBg' , 'ModeInsertBg'  },
		ProjectVisualAfter  = { 'ProjectNameBg' , 'ModeVisualBg'  },
		ProjectReplaceAfter = { 'ProjectNameBg' , 'ModeReplaceBg' },
		ProjectCommandAfter = { 'ProjectNameBg' , 'ModeCommandBg' },
		NormalAfter         = { 'ModeNormalBg'  , 'NormalBg' 	  },
		InsertAfter         = { 'ModeInsertBg'  , 'NormalBg' 	  },
		VisualAfter         = { 'ModeVisualBg'  , 'NormalBg'   	  },
		ReplaceAfter        = { 'ModeReplaceBg' , 'NormalBg'  	  },
		CommandAfter        = { 'ModeCommandBg' , 'NormalBg'  	  },
	},
	text = function()
		if vim.o.paste then
			return {
				{ ' '..sep.left_rounded, 'Paste' .. state.mode[2] .. 'After' },
				-- { '─', hl_list.StatusLine },
			}
		else
			return {
				{ sep.right_rounded, state.mode[2] .. 'After' },
				{ '─', hl_list.StatusLine },
			}
		end
	end,
}

basic.paste_mode = {
	hl_colors = {
		default             = { 'FileNameFg', 'FileNameBg'},
		sep_right_proj      = hl_list.PasteRightProjSep,
		sep_right_file      = hl_list.PasteRightFileSep,
		paste_mode          = { 'PasteModeFg' , 'PasteModeBg'  },
		FileNormalAfter     = { 'FileNameBg'  , 'ModeNormalBg' },
		FileInsertAfter     = { 'FileNameBg'  , 'ModeInsertBg' },
	},
	text = function()
		if vim.o.paste then
			return {
				{ ' ραstɛ', 'paste_mode', },
				{ sep.right_rounded, 'sep_right_file' },
				{ '─', hl_list.StatusLine },
			}
		end
	end,
}

basic.projectname = {
	name = 'projectname',
	hl_colors = {
		sep_right     = { 'ProjectNameBg', 'FileNameBg'    },
		project       = { 'ProjectNameFg', 'ProjectNameBg' },
		sep_left      = { 'ProjectNameBg', 'NormalBg'      },
		sep_left_file = { 'FileNameBg', 'NormalBg'         },
		FileName      = { 'FileFg', 'FileBg', 'italic'     },
	},
	text = function(bufnr)
		if git_comps.is_git(bufnr) then
			return {
				{ sep.left_rounded, 'sep_left' },
				{ git_comps.git_branch({icon = ' '}), 'project' },
				-- { ' ', '' },
				{ sep.right_rounded..' ', 'sep_right' },
			}
		else
			if vim.bo.filetype == 'alpha' then
				return
			else
				return {
					{ sep.left_rounded, 'sep_left_file' },
				}
			end
		end
	end,
	click = function ()
		vim.cmd('Neogit')
	end,
	width = 75
}

--[[ basic.file_leftsep = {
	hl_colors = {
		default   = {'FileNameFg',    'FileNameBg' },
		sep_right = {'ProjectNameBg', 'NormalBg'   },
		sep_left  = {'ProjectNameBg', 'NormalBg'   },
	},
	text = function(bufnr)
		if git_comps.is_git(bufnr) then
			return {
				{ sep.right_rounded, 'sep_left' },
				{ '', 'default' },
			}
		else
			return {
				{ sep.left_rounded, 'sep_left' },
				-- { '', 'default' },
			}
		end
	end,
} ]]

local function is_file_ro()
	if vim.bo.readonly then
		return ' '
	else
		return ' '
	end
end

local icon_comp = b_components.cache_file_icon({ default = '', hl_colors = {'FileNameFg','FileNameBg'} })
basic.file = {
	name = 'file',
	hl_colors = {
		default      = hl_list.File,
		FileName     = { 'FileFg', 'FileBg', 'italic'  },
		FileModified = { 'FileNameModFg', 'FileNameBg' },
		FileRO       = { 'FileNameROFg', 'FileNameBg', 'bold'  },
		FileIcon     = hl_list.FileIcon
	},
	text = function(bufnr)
		if vim.bo.filetype == 'alpha' then
			return
		else
			return {
				-- { ' ', 'FileName' },
				icon_comp(bufnr),
				{ ' ', 'FileModified' },
				{ b_components.cache_file_name('Keine!', 'unique'), 'FileName' },
				{ b_components.file_modified('✱ '), 'FileModified' },
				{ is_file_ro(), 'FileRO' },
				{ sep.right_rounded, 'default' },
				{ '─', hl_list.StatusLine },
			}
		end
	end,
}

basic.file_rightsep = {
	hl_colors = {
		default  = {'FileNameBg', 'ActiveBg'},
		sep_right_file = {'FileNameBg', 'NormalBg'},
	},
	text = function()
		if vim.bo.filetype == 'alpha' then
			return
		else
			return {
				{ sep.right_rounded, 'default' },
				-- { ' ', 'default' },
			}
		end
	end,
}

basic.git = {
	name = 'git',
	hl_colors = {
		added     = hl_list.GitDiffAdded,
		changed   = hl_list.GitDiffChanged,
		removed   = hl_list.GitDiffRemoved,
		left_sep  = { 'FileNameBg',   'ActiveBg' },
		right_sep = { 'FileNameBg',   'ActiveBg' },
	},
	text = function(bufnr)
		if git_comps.is_git(bufnr) then
			return {
				-- { '─', hl_list.StatusLine },
				{ sep.left_rounded, 'left_sep' },
				{ git_comps.diff_added({ format   = ' %s' , show_zero = true }), 'added'  },
				{ git_comps.diff_changed({ format = '  %s', show_zero = true }), 'changed' },
				{ git_comps.diff_removed({ format = '  %s', show_zero = true }), 'removed' },
	 			{ sep.right_rounded, 'right_sep' },
				{ '─', hl_list.StatusLine },
			}
		end
		return ''
	end,
	width = 70
}

-- Right side segment
---------------------------------------------
-- local check_lsp_status = lsp_comps.check_lsp({})
basic.lsp_diagnos = {
	name = 'diagnostic',
	hl_colors = {
		red    = { 'LSPDiagErrFg'  , 'FileNameBg' },
		yellow = { 'LSPDiagWarnFg' , 'FileNameBg' },
		blue   = { 'LSPDiagHintFg' , 'FileNameBg' },
		left_sep  = { 'FileNameBg',   'ActiveBg' },
		right_sep = { 'FileNameBg',   'ActiveBg' },
	},
	text = function(bufnr)
		if lsp_comps.check_lsp(bufnr) then
			return {
				{ '─', hl_list.StatusLine },
				{ sep.left_rounded, 'left_sep' },
				{ lsp_comps.lsp_hint({ format    = ' %s' , show_zero = true }), 'blue'   },
				{ lsp_comps.lsp_info({ format    = '  %s' , show_zero = true }), 'blue'   },
				{ lsp_comps.lsp_warning({ format = '  %s', show_zero = true }), 'yellow' },
				{ lsp_comps.lsp_error({ format   = '  %s', show_zero = true }), 'red'    },
				{ sep.right_rounded, 'left_sep' },
				{ '─', hl_list.StatusLine },
			}
		end
		return ''
	end,
	width =	85
}

local function lsp_client_names(component)
	local clients = {}
	local icon = component.icon or ' '
	for _, client in pairs(vim.lsp.get_clients({bufnr = 0})) do
		if client.name ==  'jedi_language_server' then
			client.name = 'jedi'
		elseif client.name ==  'sumneko_lua' then
			client.name = 'lua'
		elseif client.name ==  'null-ls' then
			client.name = 'null'
		end
		table.insert(clients, client.name)
	end

	if next(clients) == nil then
		-- return icon .. ' Keine!'
		return nil
	else
		return icon .. '(' .. table.concat(clients, ',') .. ')'
	end
end

-- local lsp_server_name = lsp_comps.lsp_name()
basic.lsp_client = {
	hl_colors = {
		sep_before       = { 'LSPClientBg', 'NormalBg' },
		sep_before_empty = { 'FileInfoBg', 'NormalBg' },
		lsp_cl           = { 'LSPClientFg', 'LSPClientBg', 'italic' },
		sep_after        = { 'LSPClientBg', 'NormalBg' },
	},
	text = function()
		if lsp_client_names({}) ~= nil then
			return {
				-- { '─', hl_list.StatusLine },
				{ sep.left_rounded, 'sep_before' },
				{ lsp_client_names({}), 'lsp_cl' },
				{ sep.right_rounded, 'sep_after' },
				-- { '─', 'StatusLine' },
			}
		else
			return
		end
	end,
	click = function ()
		vim.cmd('LspInfo')
	end,
	width = 120
}

basic.fileinfo = {
	name = 'fileinfo',
	hl_colors = {
		sep_before = { 'FileInfoBg' , 'NormalBg'   },
		sep_after  = { 'FileInfoBg' , 'NormalBg'   },
		sep        = { 'black'      , 'FileInfoBg', 'bold' },
		file_type  = { 'FileInfoFg' , 'FileInfoBg' },
		FileIcon   = hl_list.FileIcon
	},
	text = function()
		return {
			{ '─', hl_list.StatusLine },
			{ sep.left_rounded, 'sep_before' },
			{ b_components.file_type(), 'file_type' },
			{'│','sep'},
			{ b_components.file_format({icon = true}), 'file_type' },
			{ ' ', '' },
			{ sep.right_rounded, 'sep_after' },
		}
	end,
	width = 75
}

basic.indent = {
	hl_colors = {
		sep_before  = { 'IndentBg',   'NormalBg'     },
		sep_after   = { 'CursorChBg', 'NormalBg'     },
		sep         = { 'black',      'IndentBg'     },
		sep1        = { 'IndentBg',   'CursorChBg'   },
		indentcolor = { 'IndentFg',   'IndentBg'     },
		charcolor   = { 'CursorChFg', 'CursorChBg'   },
	},
	text = function()
		local sw = vim.bo.shiftwidth
		local et = vim.bo.expandtab
		local im = ''
		if et == true then
			im='•'
		else
			im='▸'
		end
		return {
			{ '─', hl_list.StatusLine },
			{ sep.left_rounded, 'sep_before' },
			{string.format('%s%s󰦪', sw, im), 'indentcolor'},
			-- {'│','sep'},
			{'','sep1'},
			-- {'','sep1'},
			{ 'Ch:%02Bh', 'charcolor' },
			{ sep.right_rounded, 'sep_after' },
		}
	end,
	width = 70
}
--                   

basic.right = {
	hl_colors = {
		sep_before = { 'RightBg'  , 'NormalBg'         },
		sep_after  = { 'RightBg'  , 'NormalBg'         },
		text       = { 'black'    , 'RightBg'          },
		lineno     = { 'LineNoFg' , 'LineNoBg'         },
		sep        = { 'black'    , 'RightBg' , 'bold' },
	},
	text = function()
		return {
			{ '─', hl_list.StatusLine },
			{ sep.left_rounded, 'sep_before' },
			{ '', 'text' },
			{' %l:%v','text'},
			{'│','sep'},
			{'%p%%','text'},
			{ sep.right_rounded, 'sep_after' },
			{ '─󰁕', hl_list.StatusLine },
		}
	end,
}

local function lazy_status()
	if require('lazy.status').has_updates() then
		return require("lazy.status").updates
	else
		return ' '..'✔ '
	end
end

basic.lazy = {
	hl_colors = {
		sep  = { 'FileNameBg', 'NormalBg' },
		text = { 'LazyFg', 'FileNameBg'},
	},
	text = function()
			return {
				{ '──', hl_list.StatusLine },
				{ sep.left_rounded, 'sep' },
				{ lazy_status(), 'text' },
				{ sep.right_rounded, 'sep' },
				{ '──', hl_list.StatusLine },
			}
	end,
}

local function getSearchCount()
	local vim_components_exits, vim_components = pcall(require, "windline.components.vim")
	if vim_components_exits then
		local search_count = vim_components.search_count()
		return search_count
	end

	return ""
end

basic.searchcount = {
	hl_colors = {
		search    = { 'FileNameModFg' , 'NormalBg' },
		cmd_text  = { 'NormalFg',    'LSPClientBg' },
		sep       = { 'LSPClientBg', 'LazyBg'      },
		lazy_text = { 'LazyFg',      'LazyBg'      },
		right_sep = { 'LazyBg',      'NormalBg'    },
	},
	text = function()
		if getSearchCount() ~= "" then
			return {
				-- { ' ', "search" },
				{ getSearchCount(), "search" },
			}
		end
	end,
}

basic.showcmd = {
	hl_colors = {
		left_sep  = { 'LSPClientBg', 'NormalBg'    },
		cmd_text  = { 'NormalFg',    'LSPClientBg' },
		sep       = { 'LSPClientBg', 'LazyBg'      },
		lazy_text = { 'LazyFg',      'LazyBg'      },
		right_sep = { 'LazyBg',      'NormalBg'    },
	},
	text = function()
		-- if require("noice").api.status.command.has() then
		-- 	return {
		-- 		{ sep.left_rounded, 'left_sep' },
		-- 		{ '⌨ ' .. require("noice").api.status.command.get() .. '', 'cmd_text' },
		-- 		{ '', 'sep' },
		-- 		{ lazy_status() or '', 'lazy_text' },
		-- 		{ sep.right_rounded, 'right_sep' },
		-- 	}
		-- end
	end,
}
--                  

local default = {
	filetypes = { 'default' },
	active = {
		{ ' ', hl_list.Active },
		basic.vi_mode,
		basic.mode_rightsep,
		basic.paste_mode,
		basic.projectname,
		basic.file,
		-- basic.searchcount,
		basic.git,
		basic.divider,
		basic.lazy,
		basic.divider,
		basic.lsp_diagnos,
		-- { ' ', hl_list.Active },
		basic.lsp_client,
		basic.fileinfo,
		basic.indent,
		basic.right,
		{ ' ', hl_list.Active },
	},

	inactive = {
		basic.file_name_inactive,
		basic.divider,
		basic.divider,
		basic.line_col_inactive,
		{ '', { 'white', 'InactiveBg' } },
		basic.progress_inactive,
	},
}

local quickfix = {
	filetypes = { 'qf', 'Trouble' },
	active = {
		{ '🚦 Quickfix ', { 'white', 'black' } },
		{ helper.separators.slant_right, { 'black', 'black_light' } },
		{
			function()
				return vim.fn.getqflist({ title = 0 }).title
			end,
			{ 'cyan', 'black_light' },
		},
		{ ' Total : %L ', { 'cyan', 'black_light' } },
		{ helper.separators.slant_right, { 'black_light', 'InactiveBg' } },
		{ ' ', { 'InactiveFg', 'InactiveBg' } },
		basic.divider,
		{ helper.separators.slant_right, { 'InactiveBg', 'black' } },
		{ '🧛 ', { 'white', 'black' } },
	},
	always_active = true,
	show_last_status = true
}

windline.setup({
	colors_name = function(colors)
		-- Common colors
		-- colors.black_light   = "#595B83"
		-- colors.green_light   = "#99c794"
		colors.NormalFg      = "#404C64"
		colors.NormalBg      = "#28303a"
		colors.ActiveFg      = "#c5cdd9"
		colors.ActiveBg      = "#28303a"
		colors.InActiveFg    = "#c5cdd9"
		colors.InActiveBg    = "#28303a"

		-- Mode
		colors.ModeNormalBg  = "#404C64"
		colors.ModeInsertBg  = "#404C64"
		colors.ModeVisualBg  = "#404C64"
		colors.ModeReplaceBg = "#404C64"
		colors.ModeCommandBg = "#404C64"

		colors.ModeNormalFg  = "#14c1f7"
		colors.ModeInsertFg  = "#99f794"
		colors.ModeVisualFg  = "#f7c99f"
		colors.ModeReplaceFg = "#FF86BC"
		colors.ModeCommandFg = "#a497fd"

		-- termguicolors
		colors.FileFg        = "#F4C493"
		colors.FileBg        = "#404C64"
		colors.FileNameFg    = "#FEFEFE"
		colors.FileNameBg    = "#404C64"
		colors.FileNameModFg = "#00AFDB"
		colors.FileNameROFg  = "#EC5F67"

		colors.PasteModeFg   = "#000000"
		colors.PasteModeBg   = "#db8a89"

		colors.GitAddedFg    = "#99c794"
		colors.GitChangedFg  = "#B99AB9"
		colors.GitRemovedFg  = "#FD5866"

		colors.LSPDiagErrFg  = "#FD5866"
		colors.LSPDiagWarnFg = "#F4C493"
		colors.LSPDiagHintFg = "#8FBCBB"

		colors.NavicFg       = "#FEFEFE"
		colors.NavicBg       = "#984ea3"

		colors.LSPClientFg   = "#000000"
		colors.LSPClientBg   = "#bab0ab"

		colors.ProjectNameFg = "#F0F0F0"
		colors.ProjectNameBg = "#907aa9"

		colors.StatusLine    = "#6B717C"

		colors.FileInfoFg    = "#000000"
		colors.FileInfoBg    = "#94789B"

		colors.IndentFg      = "#eeeeee"
		colors.IndentBg      = "#d76062"

		colors.CursorChFg    = "#eeeeee"
		colors.CursorChBg    = "#5d7277"
		colors.SearchCntFg   = "#4EB899"

		colors.LineNoFg      = "#eeeeee"
		colors.LineNoBg      = "#A070C8"
		colors.RightBg       = "#a0a0a0"

		colors.ShowCmdFg 	 = "#4EB899"
		colors.ShowCmdBg 	 = "#595B83"

		colors.LazyFg 		 = "#F4C493"
		colors.LazyBg 		 = "#384C64"

		return colors
	end,

	statuslines = {
		default,
		quickfix,
	},
})

-- local luffy = { '🌍', '🌎', '🌏' }
local luffy = { '🌑', '🌒', '🌓', '🌔', '🌕', '🌖', '🌗', '🌘' }
-- local luffy = { '􏾾', '􏾿', '􏿀', '􏿁', '􏿂', '􏿃' }
animation.stop_all()
animation.basic_animation({
    timeout = nil,
    delay = 200,
    interval = 200,
    effect = efffects.list_text(luffy),
    on_tick = function(value)
        luffy_text = value
        vim.cmd.redrawstatus()
    end
})

-- vim.opt.laststatus = 3
end

return M
--                  
