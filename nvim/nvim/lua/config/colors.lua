-- Copyright (c) 2022 Ratheesh <ratheeshreddy@gmail.com>
-- License: MIT
-- Color Configuration

-- _G.colors = {
-- 	red  = "#BF616A" , teal  = "#97B7D7"  , one_bg = "#373D49"   , lightbg  = "#3B4252"  , blue       = "#81A1C1"   ,
-- 	cyan = "#5E81AC" , black  = "#28303a" , orange  = "#D08770"  , one_bg2  = "#434C5E"  , foreground = "#EEEEEE"   ,
-- 	grey = "#4B515D" , green  = "#A3BE8C" , purple  = "#8FBCBB"  , one_bg3  = "#4C566A"  , light_grey = "#646A76"   ,
-- 	line = "#3A404C" , white  = "#D8DEE9" , yellow  = "#EBCB8B"  , lightbg2 = "#393F4B"  , dark_purple = "#B48EAD"  ,
-- 	pink = "#D57780" , black2 = "#343A46" , grey_fg  = "#606672" , baby_pink = "#DE878F" , darker_black = "#2A303C" ,
-- }

-- vim.g.terminal_color_0  = "#28303a"
-- vim.g.terminal_color_1  = "#BF616A"
-- vim.g.terminal_color_2  = "#A3BE8C"
-- vim.g.terminal_color_3  = "#EBCB8B"
-- vim.g.terminal_color_4  = "#81A1C1"
-- vim.g.terminal_color_5  = "#B48EAD"
-- vim.g.terminal_color_6  = "#5E81AC"
-- vim.g.terminal_color_7  = "#EEEEEE"
-- vim.g.terminal_color_8  = "#4C566A"
-- vim.g.terminal_color_9  = "#BF616A"
-- vim.g.terminal_color_10 = "#A3BE8C"
-- vim.g.terminal_color_11 = "#EBCB8B"
-- vim.g.terminal_color_12 = "#81A1C1"
-- vim.g.terminal_color_13 = "#B48EAD"
-- vim.g.terminal_color_14 = "#5E81AC"
-- vim.g.terminal_color_15 = "#8FBCBB"

local hl = vim.api.nvim_set_hl

hl(0 , "Normal"       , { fg = "#EEEEEE" , bg = "#28303a" , italic = false , bold = false , underline = false })
hl(0 , "NormalFloat"  , { fg = "#EEEEEE" , bg = "#28303a" , italic = false , bold = false , underline = false })
hl(0 , "FloatBorder"  , { fg = "#4C566A" , bg = nil       , italic = false , bold = true  , underline = false })
hl(0 , "FloatTitle"   , { fg = "#81A1C1" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "Bold"         , { fg = nil       , bg = nil       , italic = false , bold = true  , underline = false })
hl(0 , "Debug"        , { fg = "#D57780" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "Directory"    , { fg = "#81A1C1" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "Error"        , { fg = "#28303a" , bg = "#D57780" , italic = false , bold = false , underline = false })
hl(0 , "ErrorMsg"     , { fg = "#D57780" , bg = "#28303a" , italic = false , bold = false , underline = false })
hl(0 , "Exception"    , { fg = "#D57780" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "FoldColumn"   , { fg = "#687588" , bg = "#2B3242" , italic = false , bold = false , underline = false })
hl(0 , "Folded"       , { fg = "#4C566A" , bg = "#2B3242" , italic = false , bold = false , underline = false })
hl(0 , "IncSearch"    , { fg = nil       , bg = "#485568" , italic = false , bold = false , underline = false })
hl(0 , "Search"       , { fg = nil       , bg = "#485568" , italic = false , bold = false , underline = false })
hl(0 , "Macro"        , { fg = "#D57780" , bg = nil       , italic = false , bold = true  , underline = false })
hl(0 , "MatchParen"   , { fg = nil       , bg = nil 	  , italic = false , bold = false , underline = true  })
hl(0 , "ModeMsg"      , { fg = "#A3BE8C" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "MoreMsg"      , { fg = "#A3BE8C" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "Question"     , { fg = "#81A1C1" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "Substitute"   , { fg = "#3B4252" , bg = "#EBCB8B" , italic = false , bold = false , underline = false })
hl(0 , "SpecialKey"   , { fg = "#4C566A" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "TooLong"      , { fg = "#D57780" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "Underlined"   , { fg = "#D57780" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "Visual"       , { fg = nil       , bg = "#38485E" , italic = false , bold = false , underline = false })
hl(0 , "VisualNOS"    , { fg = "#D57780" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "WarningMsg"   , { fg = "#D57780" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "WildMenu"     , { fg = "#D57780" , bg = "#EBCB8B" , italic = false , bold = false , underline = false })
hl(0 , "Title"        , { fg = "#81A1C1" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "Conceal"      , { fg = "#81A1C1" , bg = "#28303a" , italic = false , bold = false , underline = false })
hl(0 , "Cursor"       , { fg = "#28303a" , bg = "#F0F0F0" , italic = false , bold = false , underline = false })
hl(0 , "NonText"      , { fg = "#4C566A" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "LineNr"       , { fg = "#607070" , bg = "#28303a" , italic = false , bold = false , underline = false })
hl(0 , "StatusLineNC" , { fg = "#4C566A" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "SignColumn"   , { fg = nil 		   , bg = "#28303a" , italic = false , bold = false , underline = false })
hl(0 , "StatusLine"   , { fg = "#434C5E" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "VertSplit"    , { fg = "#434C5E" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "ColorColumn"  , { fg = nil       , bg = '#3B4252' , italic = false , bold = false , underline = false })
hl(0 , "CursorColumn" , { fg = nil       , bg = nil 	  , italic = false , bold = false , underline = false })
hl(0 , "CursorLine"   , { fg = nil       , bg = "#153450" , italic = false , bold = false , underline = false })
hl(0 , "CursorLineNr" , { fg = "#b16286" , bg = "#28303a" , italic = false , bold = true , underline = false })
hl(0 , "QuickFixLine" , { fg = nil       , bg = "#3B4252" , italic = false , bold = false , underline = false })
hl(0 , "Pmenu"        , { fg = "#373D49" , bg = "#28303a" , italic = false , bold = false , underline = false })
hl(0 , "CmpPmenu"     , { fg = "#373D49" , bg = "#28303a" , italic = false , bold = false , underline = false })
hl(0 , "PmenuSbar"    , { fg = "#b16286" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "PmenuSel"     , { fg = nil 		 , bg = "#434C5E" , italic = false , bold = false , underline = false })
hl(0 , "CmpSel"       , { fg = nil 		 , bg = "#434C5E" , italic = false , bold = false , underline = false })
hl(0 , "PmenuThumb"   , { fg = "#28303a" , bg = "#474D49" , italic = false , bold = false , underline = false })
hl(0 , "TabLine"      , { fg = "#4C566A" , bg = "#3B4252" , italic = false , bold = false , underline = false })
hl(0 , "TabLineFill"  , { fg = "#4C566A" , bg = "#3B4252" , italic = false , bold = false , underline = false })
hl(0 , "TabLineSel"   , { fg = "#A3BE8C" , bg = "#e53a80" , italic = false , bold = true , underline = false  })

-- Standard syntax highlighting
hl(0 , "Boolean"      , { fg = "#D08770" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "Character"    , { fg = "#D57780" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "Comment"      , { fg = "#909090" , bg = nil       , italic = true  , bold = false , underline = false })
hl(0 , "Conditional"  , { fg = "#A3BE8C" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "Constant"     , { fg = "#5E81AC" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "Define"       , { fg = "#B48EAD" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "Delimiter"    , { fg = "#B48EAD" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "Float"        , { fg = "#D08770" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "Function"     , { fg = "#EEEEEE" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "Identifier"   , { fg = "#97B7D7" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "Include"      , { fg = "#81A1C1" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "Keyword"      , { fg = "#A3BE8C" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "Label"        , { fg = "#EBCB8B" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "Number"       , { fg = "#D08770" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "Operator"     , { fg = "#D8DEE9" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "PreProc"      , { fg = "#EBCB8B" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "Repeat"       , { fg = "#5E81AC" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "Special"      , { fg = "#D08770" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "SpecialChar"  , { fg = "#B48EAD" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "Statement"    , { fg = "#A3BE8C" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "StorageClass" , { fg = "#EBCB8B" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "String"       , { fg = "#7a8a80" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "Structure"    , { fg = "#B48EAD" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "Tag"          , { fg = "#EBCB8B" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "Todo"         , { fg = "#EBCB8B" , bg = "#3B4252" , italic = false , bold = false , underline = false })
hl(0 , "Type"         , { fg = "#EBCB8B" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "Typedef"      , { fg = "#EBCB8B" , bg = nil       , italic = false , bold = false , underline = false })

-- Diff highlighting
hl(0 , "DiffChange"  , { fg = "#4C566A" , bg = "#3B4252" , italic = false , bold = false , underline = false })
hl(0 , "DiffAdd"     , { fg = "#A3BE8C" , bg = "#3B4252" , italic = false , bold = false , underline = false })
hl(0 , "DiffDelete"  , { fg = "#D57780" , bg = "#3B4252" , italic = false , bold = false , underline = false })
hl(0 , "DiffText"    , { fg = "#81A1C1" , bg = "#3B4252" , italic = false , bold = false , underline = false })
hl(0 , "DiffAdded"   , { fg = "#A3BE8C" , bg = "#3B4252" , italic = false , bold = false , underline = false })
hl(0 , "DiffFile"    , { fg = "#D57780" , bg = "#28303a" , italic = false , bold = false , underline = false })
hl(0 , "DiffNewFile" , { fg = "#A3BE8C" , bg = "#28303a" , italic = false , bold = false , underline = false })
hl(0 , "DiffLine"    , { fg = "#81A1C1" , bg = "#28303a" , italic = false , bold = false , underline = false })
hl(0 , "DiffRemoved" , { fg = "#D57780" , bg = "#3B4252" , italic = false , bold = false , underline = false })

-- Git highlighting
hl(0 , "gitcommitOverflow"      , { fg = "#D57780" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "gitcommitSummary"       , { fg = "#A3BE8C" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "gitcommitComment"       , { fg = "#4C566A" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "gitcommitUntracked"     , { fg = "#4C566A" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "gitcommitDiscarded"     , { fg = "#4C566A" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "gitcommitSelected"      , { fg = "#4C566A" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "gitcommitHeader"        , { fg = "#B48EAD" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "gitcommitSelectedType"  , { fg = "#81A1C1" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "gitcommitUnmergedType"  , { fg = "#81A1C1" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "gitcommitDiscardedType" , { fg = "#81A1C1" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "gitcommitBranch"        , { fg = "#D08770" , bg = nil , italic = true  , bold = false , underline = false })
hl(0 , "gitcommitOnBranch"      , { fg = "#909090" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "gitcommitUntrackedFile" , { fg = "#EBCB8B" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "gitcommitUnmergedFile"  , { fg = "#D57780" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "gitcommitDiscardedFile" , { fg = "#D57780" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "gitcommitSelectedFile"  , { fg = "#A3BE8C" , bg = nil , italic = false , bold = false , underline = false })

hl(0, "BufferCurrent"           ,{ fg = "#e5d8bd", bg = "#4C5D79", italic = true,  bold = false, underline = false })
hl(0, "BufferCurrentNumber"     ,{ fg = "#F388AF", bg = "#4C5D79", italic = true,  bold = true,  underline = false })
hl(0, "BufferCurrentIndex"      ,{ fg = "#F388AF", bg = "#4C5D79", italic = false, bold = false, underline = false })
hl(0, "BufferCurrentIcon"       ,{ fg = nil      , bg = "#4C5D79", italic = false, bold = false, underline = false })
hl(0, "BufferDefaultCurrentIcon",{ fg = nil      , bg = "#4C5D79", italic = false, bold = false, underline = false })
hl(0, "BufferCurrentMod"        ,{ fg = "#e5d8bd", bg = "#4C5D79", italic = true,  bold = false, underline = false })
hl(0, "BufferCurrentTarget"     ,{ fg = "#FA2C77", bg = "#4C5D79", italic = true , bold = true , underline = true  })
hl(0, "BufferCurrentSign"       ,{ fg = "#4C5D79", bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferCurrentERROR"      ,{ fg = "#FA2C77", bg = "#4C5D79", italic = false, bold = false, underline = false })
hl(0, "BufferCurrentHINT"       ,{ fg = nil      , bg = "#4C5D79", italic = false, bold = false, underline = false })
hl(0, "BufferCurrentINFO"       ,{ fg = nil      , bg = "#4C5D79", italic = false, bold = false, underline = false })

hl(0, "BufferInActive"          ,{ fg = "#99c794", bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferInactiveIndex"     ,{ fg = "#988C99", bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferInactiveIcon"      ,{ fg = nil      , bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferInactive"          ,{ fg = "#988C99", bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferInactiveTarget"    ,{ fg = "#FA2C77", bg = "#243440", italic = true , bold = true , underline = true  })
hl(0, "BufferInactiveMod"       ,{ fg = "#988C99", bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferInactiveSign"      ,{ fg = "#4C5D79", bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferInactiveERROR"     ,{ fg = "#FA2C77", bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferInactiveHINT"      ,{ fg = nil      , bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferInactiveINFO"      ,{ fg = nil      , bg = "#243440", italic = false, bold = false, underline = false })

hl(0, "BufferVisible"           ,{ fg = "#99c794", bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferVisibleMod"        ,{ fg = "#EFEAD8", bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferVisibleSign"       ,{ fg = "#988C99", bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferVisibleTarget"     ,{ fg = "#EFEAD8", bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferVisibleIndex"      ,{ fg = "#988C99", bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferVisibleIcon"       ,{ fg = nil      , bg = "#243440", italic = false, bold = false, underline = false })

hl(0, "BufferTabLineSel"        ,{ fg = "#EFEAD8", bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferTabLineFill"       ,{ fg = "#EFEAD8", bg = "#243440", italic = false, bold = false, underline = false })
hl(0, "BufferTabPageFill"       ,{ fg = "#EFEAD8", bg = "#243440", italic = false, bold = false, underline = false })

hl(0 , "EndOfBuffer"				 		, { fg = "#28303a" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "NvimInternalError"	 		, { fg = "#BF616A" , bg = nil       , italic = false , bold = false , underline = false })

-- Gitsigns
-- sign column
hl(0 , "GitSignsAdd"                , { fg = "#0BC294" , bg = "#28303a" , italic = false , bold = true  , underline = false })
hl(0 , "GitSignsChange"             , { fg = "#7f7f7f" , bg = "#28303a" , italic = false , bold = true  , underline = false })
hl(0 , "GitSignsDelete"             , { fg = "#E23D75" , bg = "#28303a" , italic = false , bold = true  , underline = false })

hl(0 , "GitSignsAddNr"              , { fg = "#a0a0a0" , bg = "#2a4a56" , italic = false , bold = false , underline = false })
hl(0 , "GitSignsChangeNr"           , { fg = "#a0a0a0" , bg = "#2a4a56" , italic = false , bold = false , underline = false })
hl(0 , "GitSignsModifiedNr"         , { fg = "#a0a0a0" , bg = "#2a4a56" , italic = false , bold = false , underline = false })

hl(0 , "GitSignsAddLn"        		, { fg = "#A3BE8C" , bg = "#2a384e" , italic = false , bold = false , underline = false })
hl(0 , "GitSignsChangeLn"     		, { fg = "#A3BE8C" , bg = "#2a384e" , italic = false , bold = false , underline = false })
hl(0 , "GitSignsDeleteLn"     		, { fg = "#D57780" , bg = "#2a384e" , italic = false , bold = false , underline = false })

-- preview hunk
hl(0 , "GitSignsAddPreview"         , { fg = "#A3BE8C" , bg = "#3C465A" , italic = false , bold = false , underline = false })
hl(0 , "GitSignsChangePreview"      , { fg = "#A3BE8C" , bg = "#3C465A" , italic = false , bold = false , underline = false })
hl(0 , "GitSignsDeletePreview"      , { fg = "#D57780" , bg = "#3C465A" , italic = false , bold = false , underline = false })
-- buffer
hl(0 , "GitSignsAddLine"        	, { fg = "#A3BE8C" , bg = "#3C465A" , italic = false , bold = false , underline = false })
hl(0 , "GitSignsChangeLine"     	, { fg = "#A3BE8C" , bg = "#3C465A" , italic = false , bold = false , underline = false })
hl(0 , "GitSignsDeleteLine"     	, { fg = "#D57780" , bg = "#3C465A" , italic = false , bold = false , underline = false })

hl(0 , "GitSignsAddInline"          , { fg = "#A3BE8C" , bg = "#606672" , italic = false , bold = false , underline = false })
hl(0 , "GitSignsChangeInline"       , { fg = "#A3BE8C" , bg = "#606672" , italic = false , bold = false , underline = false })
hl(0 , "GitSignsDeleteInline"       , { fg = "#D57780" , bg = "#606672" , italic = false , bold = false , underline = false })

hl(0 , "GitSignsAddLnInline"        , { fg = "#A3BE8C" , bg = "#606672" , italic = false , bold = false , underline = false })
hl(0 , "GitSignsChangeLnInline"     , { fg = "#A3BE8C" , bg = "#606672" , italic = false , bold = false , underline = false })
hl(0 , "GitSignsDeleteLnInline"     , { fg = "#D57780" , bg = "#606672" , italic = false , bold = false , underline = false })

hl(0 , "GitSignsAddVirtLnInline"    , { fg = "#A3BE8C" , bg = "#606672" , italic = false , bold = false , underline = false })
hl(0 , "GitSignsChangeVirtLnInline" , { fg = "#A3BE8C" , bg = "#606672" , italic = false , bold = false , underline = false })
hl(0 , "GitSignsDeleteVirtLnInline" , { fg = "#D57780" , bg = "#606672" , italic = false , bold = false , underline = false })

hl(0 , "GitSignsStagedAdd"          , { fg = "#A3BE8C" , bg = nil , italic = false , bold = true , underline = false })
hl(0 , "GitSignsStagedChange"       , { fg = "#808682" , bg = nil , italic = false , bold = true , underline = false })
hl(0 , "GitSignsStagedDelete"       , { fg = "#D57780" , bg = nil , italic = false , bold = true , underline = false })
--
hl(0 , "GitSignsStagedAddNr"      	, { fg = "#000000" , bg = "#CBAA91" , italic = false , bold = false , underline = false })
hl(0 , "GitSignsStagedChangeNr"   	, { fg = "#F0F0F0" , bg = "#4C5D79" , italic = false , bold = false , underline = false })
hl(0 , "GitSignsStagedDeleteNr"   	, { fg = "#000000" , bg = "#D57780" , italic = false , bold = false , underline = false })

-- nvim-cmp
hl(0 , "CmpDocNormal"             , { fg = "#b0b0b0" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemAbbr"           	  , { fg = "#909090" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemAbbrMatchFuzzy" 	  , { fg = "#D57780" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemAbbrMatch"      	  , { fg = "#6888b4" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemMatch"          	  , { fg = "#eeeeee" , bg = nil , italic = false , bold = false , underline = true  })
hl(0 , "CmpItemAbbrDeprecated" 	  , { fg = "#eeeeee" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemKind"           	  , { fg = "#F7B0BA" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemMenu"           	  , { fg = "#6E7179" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemKindVariable"   	  , { fg = "#C76D83" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemKindInterface"  	  , { fg = "#0097BF" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemKindText"       	  , { fg = "#C586C0" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemKindFunction"   	  , { fg = "#A3BE8C" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemKindMethod"     	  , { fg = "#4d708c" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemKindKeyword"    	  , { fg = "#fbb4ae" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemKindSnippet"    	  , { fg = "#9467bd" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemKindConstructor"   , { fg = "#A3BE8C" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemKindField"         , { fg = "#9467bd" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemKindClass"         , { fg = "#9c755f" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemKindModule"        , { fg = "#4C5D79" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemKindProperty"      , { fg = "#A06372" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemKindUnit"          , { fg = "#8c755f" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemKindValue"         , { fg = "#EBCB8B" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemKindEnum"          , { fg = "#9467bd" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemKindColor"         , { fg = "#97B7D7" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemKindFile"          , { fg = "#E0AF8F" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemKindReference"     , { fg = "#97B7D7" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemKindFolder"        , { fg = "#E0AF8F" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemKindEnumMember"    , { fg = "#3D7BBF" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemKindConstant"      , { fg = "#6B717C" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemKindStruct"        , { fg = "#af7aa1" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemKindEvent"         , { fg = "#3D7BBF" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemKindOperator"      , { fg = "#bf8da7" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpItemKindTypeParameter" , { fg = "#97B7D7" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "CmpGhostText"          	  , { fg = "#707080" , bg = nil , italic = true  , bold = false , underline = false })

hl(0 , "IndentBlanklineChar" , { fg = "#3A404C" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "DiagnosticError"     , { fg = "#BF616A" , bg = nil , italic = false , bold = true , underline = false })
hl(0 , "DiagnosticWarn"      , { fg = "#EBCB8B" , bg = nil , italic = false , bold = true , underline = false })
hl(0 , "DiagnosticInfo"      , { fg = "#A3BE8C" , bg = nil , italic = false , bold = true , underline = false })
hl(0 , "DiagnosticHint"      , { fg = "#8FBCBB" , bg = nil , italic = false , bold = true , underline = false })
hl(0 , "NotifyINFOBorder"    , { fg = "#A3BE8C" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "NotifyINFOTitle"     , { fg = "#A3BE8C" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "NotifyINFOIcon"      , { fg = "#A3BE8C" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "NotifyWARNBorder"    , { fg = "#EBCB8B" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "NotifyWARNTitle"     , { fg = "#EBCB8B" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "NotifyWARNIcon"      , { fg = "#EBCB8B" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "NotifyERRORBorder"   , { fg = "#BF616A" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "NotifyERRORTitle"    , { fg = "#BF616A" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "NotifyERRORIcon"     , { fg = "#BF616A" , bg = nil , italic = false , bold = false , underline = false })

hl(0 , "WhichKey"            , { fg = "#FA2C77" , bg = nil , italic = false , bold = true , underline = false })
hl(0 , "WhichKeyGroup"       , { fg = "#9467bd" , bg = nil , italic = false , bold = true , underline = false })
hl(0 , "WhichKeyValue"       , { fg = "#8FBCBB" , bg = nil , italic = false , bold = false , underline = false })

-- special attribute which require sp and undercurl attributes only
hl(0 , "DiagnosticUnderlineError" , { fg = nil, bg = nil , italic = false , bold = false , underline = false, undercurl = true, sp ='#F06372' })
hl(0 , "DiagnosticUnderlineWarn"  , { fg = nil, bg = nil , italic = false , bold = false , underline = false, undercurl = true, sp ='#E0AF8F' })
hl(0 , "DiagnosticUnderlineInfo"  , { fg = nil, bg = nil , italic = false , bold = false , underline = false, undercurl = true, sp ='#6B717C' })
hl(0 , "DiagnosticUnderlineHint"  , { fg = nil, bg = nil , italic = false , bold = false , underline = false, undercurl = true, sp ='#9467bd' })

hl(0 , "LspReferenceRead"  , { fg = nil , bg = "#3B4252" , italic = false , bold = false , underline = false })
hl(0 , "LspReferenceWrite" , { fg = nil , bg = "#3B4252" , italic = false , bold = false , underline = false })

-- Treesitter highlighting
hl(0, "@boolean",                { fg = "#CEB69A", bg = nil, italic = true,  bold = false, underline = false })
hl(0, "@character",              { fg = "#5fb4b4", bg = nil, italic = false, bold = false, underline = false })
hl(0, "@character.special",      { fg = "#5fb4b4", bg = nil, italic = false, bold = false, underline = false })
hl(0, "@comment",                { fg = "#a6acb8", bg = nil, italic = false, bold = false, underline = false })
hl(0, "@conditional",            { fg = "#cc8ec6", bg = nil, italic = false, bold = false, underline = false })
hl(0, "@constant",               { fg = "#d8dee9", bg = nil, italic = false, bold = false, underline = false })
hl(0, "@constant.builtin",       { fg = "#d8dee9", bg = nil, italic = true,  bold = false, underline = false })
hl(0, "@constant.macro",         { fg = "#cc8ec6", bg = nil, italic = true,  bold = false, underline = false })
hl(0, "@constructor.javascript", { fg = "#f9ae58", bg = nil, italic = true,  bold = false, underline = false })
hl(0, "@constructor.lua",        { fg = "#d8dee9", bg = nil, italic = false, bold = false, underline = false })
hl(0, "@constructor.typescript", { fg = "#f9ae58", bg = nil, italic = true,  bold = false, underline = false })
hl(0, "@enum",                   { fg = "#f9ae58", bg = nil, italic = true,  bold = false, underline = false })
-- exception.rust
hl(0, "@field",                  { fg = "#95b2d6", bg = nil, italic = false, bold = false, underline = false })
-- field.toml
-- field.toyaml
hl(0, "@float",               			{ fg = "#fac761", bg = nil, 	  italic = false, bold = false, underline = false })
hl(0, "@function",            			{ fg = "#c8c8c8", bg = nil, 	  italic = false, bold = false, underline = false })
hl(0, "@function.builtin",    			{ fg = "#bab0ab", bg = nil, 	  italic = false, bold = false, underline = false })
hl(0, "@function.call",       			{ fg = "#5c99d6", bg = nil, 	  italic = false, bold = false, underline = false })
hl(0, "@function.css",        			{ fg = "#5c99d6", bg = nil, 	  italic = false, bold = false, underline = false })
hl(0, "@function.macro",      			{ fg = "#5c99d6", bg = nil, 	  italic = false, bold = false, underline = false })
hl(0, "@include",             			{ fg = "#cc8ec6", bg = nil, 	  italic = false, bold = false, underline = false })
hl(0, "@interface",           			{ fg = "#f9ae58", bg = nil, 	  italic = false, bold = false, underline = false })
hl(0, "@keyword",             			{ fg = "#cc8ec6", bg = nil, 	  italic = true,  bold = false, underline = false })
hl(0, "@keyword.function",    			{ fg = "#cc8ec6", bg = nil, 	  italic = true,  bold = false, underline = false })
hl(0, "@keyword.operator",    			{ fg = "#f97b58", bg = nil, 	  italic = false, bold = false, underline = false })
hl(0, "@keyword.return",      			{ fg = "#cc8ec6", bg = nil, 	  italic = false, bold = false, underline = false })
hl(0, "@label",               			{ fg = "#5fb4b4", bg = nil, 	  italic = false, bold = false, underline = false })
hl(0, "@label.json",          			{ fg = "#5fb4b4", bg = nil, 	  italic = false, bold = false, underline = false })
hl(0, "@label.toml",          			{ fg = "#5fb4b4", bg = nil, 	  italic = false, bold = false, underline = false })
hl(0, "@label.vim",           			{ fg = "#95b2d6", bg = nil, 	  italic = false, bold = false, underline = false })
hl(0, "@method",              			{ fg = "#5fb4b4", bg = nil, 	  italic = false, bold = false, underline = false })
hl(0, "@method.call",         			{ fg = "#5c99d6", bg = nil, 	  italic = false, bold = false, underline = false })
hl(0, "@namespace",           			{ fg = "#f9ae58", bg = nil, 	  italic = false, bold = false, underline = false })
hl(0, "@number",              			{ fg = "#D19491", bg = nil, 	  italic = false, bold = false, underline = false })
hl(0, "@number.bash",         			{ fg = "#f9ae58", bg = nil, 	  italic = false, bold = false, underline = false })
hl(0, "@operator",            			{ fg = "#e96b48", bg = nil, 	  italic = false, bold = false, underline = false })
hl(0, "@parameter.c",               { fg = "#E7839F", bg = nil, 	  italic = true,  bold = false, underline = false })
hl(0, "@parameter.bash",      			{ fg = "#d8dee9", bg = nil, 	  italic = true,  bold = false, underline = false })
-- hl(0, "@parameter.reference", 			{ fg = "#d8dee9", bg = nil, 	  italic = true,  bold = false, underline = false })
hl(0, "@preproc",             			{ fg = "#5fb4b4", bg = nil, 	  italic = false, bold = false, underline = false })
hl(0, "@property",            			{ fg = "#95b2d6", bg = nil, 	  italic = false, bold = false, underline = false })
hl(0, "@property.toml",       			{ fg = "#5fb4b4", bg = nil, 	  italic = false, bold = false, underline = false })
hl(0, "@punctuation",         			{ fg = "#a6acb8", bg = nil, 	  italic = false, bold = true,  underline = false })
hl(0, "@punctuation.delimiter",         { fg = "#a6acb8", bg = nil,       italic = false, bold = true,  underline = false })
hl(0, "@punctuation.bracket",           { fg = nil,       bg = nil,       italic = false, bold = true,  underline = false })
hl(0, "@punctuation.delimiter.python",  { fg = "#f7f7f7", bg = nil,       italic = false, bold = true,  underline = false })
hl(0, "@punctuation.delimiter.yaml",    { fg = "#5c99d6", bg = nil,       italic = false, bold = true,  underline = false })
hl(0, "@punctuation.special",           { fg = "#5fb4b4", bg = nil,       italic = false, bold = true,  underline = false })
hl(0, "@punctuation.special.markdown",  { fg = "#f97b58", bg = nil,       italic = false, bold = false, underline = false })
hl(0, "@repeat",                        { fg = "#cc8ec6", bg = nil,       italic = false, bold = false, underline = false })
hl(0, "@repeat.python",                 { fg = "#ec5f66", bg = nil,       italic = false, bold = false, underline = false })
hl(0, "@storageclass",                  { fg = "#ec5f66", bg = nil,       italic = false, bold = false, underline = false })
hl(0, "@storageclass.lifetime",         { fg = "#ec5f66", bg = nil,       italic = false, bold = false, underline = false })
hl(0, "@string",                        { fg = "#99c794", bg = nil,       italic = false, bold = false, underline = false })
hl(0, "@string.escape",                 { fg = "#5fb4b4", bg = nil,       italic = false, bold = false, underline = false })
hl(0, "@string.regex",                  { fg = "#5fb4b4", bg = nil,       italic = false, bold = false, underline = false })
hl(0, "@string.special",                { fg = "#5fb4b4", bg = nil,       italic = false, bold = false, underline = false })
hl(0, "@symbol",                        { fg = "#5fb4b4", bg = nil,       italic = false, bold = false, underline = false })
hl(0, "@tag",                           { fg = "#ec5f66", bg = nil,       italic = false, bold = false, underline = false })
hl(0, "@tag.attribute",                 { fg = "#cc8ec6", bg = nil,       italic = false, bold = false, underline = false })
hl(0, "@tag.delimiter",                 { fg = "#5fb4b4", bg = nil,       italic = false, bold = false, underline = false })
hl(0, "@tag.markdown",                  { fg = "#5c99d6", bg = nil,       italic = false, bold = false, underline = false })
hl(0, "@tag.markdown_inline",           { fg = "#5c99d6", bg = nil,       italic = false, bold = false, underline = false })
hl(0, "@tag.rust",                      { fg = "#5fb4b4", bg = nil,       italic = false, bold = false, underline = false })
hl(0, "@tag.rust.lua",                  { fg = "#5fb4b4", bg = nil,       italic = false, bold = false, underline = false })
hl(0, "@text",                          { fg = "#d8dee9", bg = nil,       italic = false, bold = false, underline = false })
hl(0, "@text.emphasis",                 { fg = nil,       bg = nil,       italic = true,  bold = true,  underline = false })
hl(0, "@text.literal",                  { fg = "#99c794", bg = nil,       italic = true,  bold = false, underline = false })
hl(0, "@text.literal.markdown_inline",  { fg = "#99c794", bg = "#3b454e", italic = false, bold = false, underline = false })
hl(0, "@text.reference",                { fg = "#5fb4b4", bg = nil,       italic = false, bold = false, underline = false })
hl(0, "@text.strong",                   { fg = nil,       bg = nil,       italic = false, bold = true,  underline = false })
hl(0, "@text.title",                    { fg = "#d8dee9", bg = nil,       italic = false, bold = true,  underline = false })
hl(0, "@text.underline",                { fg = nil,       bg = nil,       italic = false, bold = false, underline = true  })
hl(0, "@text.uri",                      { fg = "#5c99d6", bg = nil,       italic = false, bold = false, underline = false })
hl(0, "@type",                          { fg = "#5c99d6", bg = nil,       italic = false, bold = false, underline = false })
hl(0, "@type.builtin",                  { fg = "#5c99d6", bg = nil,       italic = false, bold = false, underline = false })
hl(0, "@type.definition",               { fg = "#f9ae58", bg = nil,       italic = false, bold = false, underline = false })
hl(0, "@type.qualifier",                { fg = "#ec5f66", bg = nil,       italic = false, bold = false, underline = false })
hl(0, "@variable",                      { fg = "#BFC1C7", bg = nil,       italic = false, bold = false, underline = false })
hl(0, "@variable.builtin",              { fg = "#BFC1C7", bg = nil,       italic = true,  bold = false, underline = false })
hl(0, "@variable.javascript",           { fg = "#BFC1C7", bg = nil,       italic = false, bold = false, underline = false })
hl(0, "@variable",                      { fg = "#BFC1C7", bg = nil,       italic = false, bold = false, underline = false })
hl(0, "@define",                        { fg = "#4b8a8d", bg = nil,       italic = false, bold = false, underline = false })
hl(0, "@constructor",                   { fg = "#a0a0a0", bg = nil,       italic = false, bold = false, underline = false })

-- hl(0 , "@constant"            , { fg = "#709081" , bg = nil , italic = false , bold = false , underline = false })
-- hl(0 , "@type.definition"     , { fg = "#a0a0a0" , bg = nil , italic = false , bold = false , underline = false })

hl(0, "cIncluded",			 { fg = "#7d8590", bg = nil, italic = true,  bold = false, underline = false })
hl(0, "cCppOutIf2",			 { fg = "#3d4570", bg = nil, italic = false, bold = false, underline = false })
hl(0, "pythonTSComment",	 { fg = "#909090", bg = nil, italic = true,  bold = false, underline = false })

-- javascript
hl(0 , "javaScriptMember"    , { fg = "#5F9EA0" , bg = nil , italic = true  , bold = false , underline = false })

-- jinja2
hl(0 , "jinjaVarDelim"      , { fg = "#EB6D7F" , bg = nil , italic = false , bold = true  , underline = false })
hl(0 , "jinjaVariable"      , { fg = "#5F9EA0" , bg = nil , italic = true  , bold = false , underline = false })
hl(0 , "jinjaTagDelim"      , { fg = "#EB6D7F" , bg = nil , italic = false , bold = true  , underline = false })
hl(0 , "jinjaStatement"     , { fg = "#bd93f9" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "jinjaBlockName"     , { fg = "#5F9EA0" , bg = nil , italic = true  , bold = true  , underline = false })

hl(0 , "djangoTagBlock"     , { fg = "#bd93f9" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "djangoStatement"    , { fg = "#BE6169" , bg = nil , italic = true , bold = false , underline = false })
hl(0 , "djangoVarBlock"     , { fg = "#00AFDB" , bg = nil , italic = true , bold = false , underline = false })

-- Fidget
hl(0 , "FidgetTask"         , { fg = "#B6919E" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "FidgetTitle"        , { fg = "#2AD198" , bg = nil , italic = false , bold = false , underline = false })

-- wilder.nvim
hl(0 , "WildMenu"           , { fg = "#000000" , bg = "#8F575A" , italic = true  , bold = false , underline = false })
hl(0 , "WildStatus"         , { fg = "#c0c0c0" , bg = "#1A3A59" , italic = false , bold = false , underline = false })
hl(0 , "WildSelected"       , { fg = "#d5b07B" , bg = "#3d506c" , italic = true  , bold = false , underline = false })
hl(0 , "WildSelectedAccent" , { fg = "#2AD198" , bg = "#3d506c" , italic = true  , bold = true  , underline = false })
hl(0 , "WildMode"           , { fg = "#f0f0f0" , bg = "#6B717C" , italic = true  , bold = false , underline = false })
hl(0 , "WildSeparator"      , { fg = "#bd93f9" , bg = "#1A3A59" , italic = false , bold = false , underline = false })
hl(0 , "WildAccent"         , { fg = "#ec7279" , bg = "#1A3A59" , italic = false , bold = false , underline = false })
hl(0 , "WildIndex"          , { fg = "#f0f0f0" , bg = "#4d708c" , italic = false , bold = false , underline = false })
hl(0 , "WildSepLeft"        , { fg = "#FCCC82" , bg = "#1A3A59" , italic = false , bold = false , underline = false })
hl(0 , "WildSepRight2"      , { fg = "#FCCC82" , bg = "#1A3A59" , italic = false , bold = false , underline = false })
hl(0 , "WildSepLeft"        , { fg = "#FCCC82" , bg = "#1A3A59" , italic = false , bold = false , underline = false })
hl(0 , "WildSepRight2"      , { fg = "#FCCC82" , bg = "#1A3A59" , italic = false , bold = false , underline = false })

hl(0, "MarkSignNumHL", { fg = "#c0c0c0", bg = "#4a6470", italic = false, bold = true, underline = false })

hl(0, "iCursor", { fg = "#ff5555", bg = "#ff5555", italic = false, bold = true, underline = false })
hl(0, "nCursor", { fg = "#f2f2f2", bg = "#f2f2f2", italic = false, bold = true, underline = false })
hl(0, "vCursor", { fg = "#FCCC82", bg = "#FCCC82", italic = false, bold = true, underline = false })
hl(0, "rCursor", { fg = "#d65b84", bg = "#d65b84", italic = false, bold = true, underline = false })
hl(0, "oCursor", { fg = "#00ff00", bg = "#00ff00", italic = false, bold = true, underline = false })

-- Noice
hl(0 , "NoiceCmdlineCmdline"    , { fg = "#FA2C77" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "NoiceCmdlinePopupBorder", { fg = "#858ba8" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "NoiceCmdlineIcon" 		, { fg = "#1bb1e7" , bg = nil , italic = false , bold = true  , underline = false })
hl(0 , "NoicePopupMenuMatch" 	, { fg = "#1bb1e7" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "NoiceLspProgressTitle"  , { fg = "#858ba8" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "NoiceLspProgressClient" , { fg = "#AC6BF1" , bg = nil , italic = true  , bold = true  , underline = false })
hl(0 , "NoiceLspProgressTodo"   , { fg = "#AC6BF1" , bg = nil , italic = true  , bold = false , underline = false })
hl(0 , "NoiceLspProgressDone"   , { fg = "#A3BE8C" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "NoiceVirtualText"       , { fg = "#F7CAB8" , bg = nil , italic = true  , bold = false , underline = false })

-- Lazy
hl(0 , "LazyProgressTodo"   , { fg = "#858ba8" , bg = nil , italic = true  , bold = false , underline = false })
hl(0 , "LazyProgressDone"   , { fg = "#FCCC82" , bg = nil , italic = false , bold = false , underline = false })

-- LeaderF
hl(0 , "Lf_hl_popup_window"    , { fg = "#c0c0c0" , bg = "#28303a" , italic = false , bold = false , underline = false })
hl(0 , "Lf_hl_popup_inputText" , { fg = "#c0c0c0" , bg = "#28303a" , italic = false , bold = false , underline = false })
hl(0 , "Lf_hl_popupBorder"     , { fg = "#e79498" , bg = "#28303a" , italic = false , bold = false , underline = false })
hl(0 , "Lf_hl_popup_prompt"    , { fg = "#FA2C77" , bg = "#28303a" , italic = false , bold = true  , underline = false })
hl(0 , "Lf_hl_cursorline"      , { fg = "#858ba8" , bg = nil       , italic = false , bold = false , underline = false })
hl(0 , "Lf_hl_match"      	   , { fg = "#EB6D7F" , bg = nil       , italic = true  , bold = false , underline = false })

-- mini.nvim
hl(0, "MiniIndentscopeSymbol", { fg = "#3F4F5B", bg = nil, italic = false, bold = false, underline = false })
hl(0, "MiniSurround"         , { fg = "#ec7279", bg = nil, italic = false, bold = false, underline = false })

-- VirtColumn
hl(0, "VirtColumn", { fg = "#304044", bg = nil, italic = false, bold = true, underline = false })

-- nvim-treesitter-context
hl(0, "TreesitterContext", { fg = nil, bg = "#28303a", italic = false, bold = false, underline = false })
hl(0, "TreesitterContextBottom", { fg = nil, bg = "#28303a", italic = false, bold = false, underline = true, sp = "#28303a" })
-- hi TreesitterContextBottom gui=underline guisp=Grey

-- nvim-surround
hl(0, "NvimSurroundHighlightTextObject", { fg = "#FCCC82", bg = "#1A3A59", italic = true, bold = false, underline = false })

-- QuickScope
hl(0, "QuickScopeSecondary", { fg = "#FCCC82", bg = "#1A3A59", italic = true, bold = false, underline = false })

-- lsp-signature
hl(0, "LspSignatureActiveParameter", { fg = "#6E7179", bg = "#1A3A59", italic = true, bold = false, underline = false })

-- Startify
hl(0 , "StartifyNumber"  , { fg = "#cc9977" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "StartifySelect"  , { fg = nil       , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "StartifyBracket" , { fg = "#6E7179" , bg = nil , italic = false , bold = true  , underline = false })
hl(0 , "StartifySpecial" , { fg = "#cd5c5c" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "StartifyPath"    , { fg = "#64648a" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "StartifyFile"    , { fg = "#00707B" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "StartifySlash"   , { fg = "#897588" , bg = nil , italic = false , bold = false , underline = false })
hl(0 , "StartifyHeader"  , { fg = "#6E7179" , bg = nil , italic = false , bold = true  , underline = false })
hl(0 , "StartifySection" , { fg = "#00afcb" , bg = nil , italic = true  , bold = false , underline = false })
hl(0 , "StartifyFooter"  , { fg = "#a0a0a0" , bg = nil , italic = false , bold = false , underline = false })

-- rainbow
-- hl(0, "TSRainbowRed", { fg = "#BF616A", bg = nil, italic = false, bold = true, underline = false })
-- hl(0, "TSRainbowBlue", { fg = "#81A1C1", bg = nil, italic = false, bold = true, underline = false })
-- hl(0, "TSRainbowYellow", { fg = "#d5b07B", bg = nil, italic = false, bold = true, underline = false })
-- hl(0, "TSRainbowOrange", { fg = "#AA4499", bg = nil, italic = false, bold = true, underline = false })
-- hl(0, "TSRainbowGreen", { fg = "#FA2CA7", bg = nil, italic = false, bold = true, underline = false })
-- hl(0, "TSRainbowViolet", { fg = "#B3C1A9", bg = nil, italic = false, bold = true, underline = false })
-- hl(0, "TSRainbowCyan", { fg = "#bd93f9", bg = nil, italic = false, bold = true, underline = false })

-- nvim-rainbow-ts - #65C3AD #E8C060 #33AFFF #2AA198
hl(0, "rainbowcol1", { fg = "#4682B4", bg = nil, italic = false, bold = true, underline = false })
hl(0, "rainbowcol2", { fg = "#BF616A", bg = nil, italic = false, bold = true, underline = false })
hl(0, "rainbowcol3", { fg = "#1D8D77", bg = nil, italic = false, bold = true, underline = false })
hl(0, "rainbowcol4", { fg = "#8661AD", bg = nil, italic = false, bold = true, underline = false })
hl(0, "rainbowcol5", { fg = "teal"   , bg = nil, italic = false, bold = true, underline = false })
hl(0, "rainbowcol6", { fg = "#d5b07B", bg = nil, italic = false, bold = true, underline = false })
hl(0, "rainbowcol7", { fg = "#50AFBB", bg = nil, italic = false, bold = true, underline = false })

hl(0 , "ScrollView"    , { fg = nil       , bg = "#54586A" , italic = false , bold = false , underline = false })
hl(0 , "SearchCurrent" , { fg = "#FB391F" , bg = nil       , italic = false , bold = true  , underline = false })
hl(0 , "SearchSV"      , { fg = "#FCC077" , bg = nil       , italic = false , bold = false , underline = false })

-- vim-sandwich
hl(0, "OperatorSandwichBuns",   { fg = "#fbb4ae", bg = "#3E5062", italic = false, bold = true, underline = true  })
hl(0, "OperatorSandwichAdd",    { fg = "#99c794", bg = nil 		, italic = false, bold = true, underline = true  })
hl(0, "OperatorSandwichDelete", { fg = "#F06372", bg = nil 		, italic = false, bold = true, underline = true  })
hl(0, "OperatorSandwichChange", { fg = "#C586C0", bg = "#3E5062", italic = false, bold = true, underline = false })

hl(0, "InclineFileName", { fg = "#F06372", bg = nil, 			 italic = false, bold = false, underline = false })
hl(0, "InclineNormal"  , { fg = "#E0E0E0", bg = "#444864", italic = false, bold = false, underline = false })
hl(0, "InclineNormalNC", { fg = "#E0E0E0", bg = "#444864", italic = false, bold = false, underline = false })

hl(0 , "hiPairs_matchPair" , { fg = nil       , bg = nil , italic = false , bold = false , underline = true })

hl(0 , "LspInfoBorder"   , { fg = "#4C566A" , bg = nil , italic = false , bold = true , underline = false })

hl(0 , "LspInlayHint"   , { fg = "#5C667A" , bg = nil , italic = true , bold = false , underline = false })

-- Glance
hl(0 , "GlanceWinBarTitle"    , { fg = "#E0E0E0" , bg = "#444864" , italic = true , bold = false , underline = false })
hl(0 , "GlanceWinBarFilename" , { fg = "#E0E0E0" , bg = "#444864" , italic = true , bold = false , underline = false })
hl(0 , "GlanceWinBarFilepath" , { fg = "#E0E0E0" , bg = "#444864" , italic = true , bold = false , underline = false })
hl(0 , "GlanceListFilename"   , { fg = "#E0E0E0" , bg = "#444864" , italic = true , bold = false , underline = false })
hl(0 , "GlanceListFilepath"   , { fg = "#E0E0E0" , bg = "#444864" , italic = true , bold = false , underline = false })

hl(0 , "SatelliteSearch"        , { fg = "#D57780" , bg = "#444864" , italic = true , bold = false , underline = false })
hl(0 , "SatelliteSearchCurrent" , { fg = "#E0E030" , bg = "#444864" , italic = true , bold = false , underline = false })

-- vim notifer
hl(0 , "NotifierContent"   , { fg = "#6B717C" , bg = nil , italic = false, bold = false , underline = false })
hl(0 , "NotifierContentDim", { fg = "#6B717C" , bg = nil , italic = true , bold = false , underline = false })
hl(0 , "NotifierTitle"     , { fg = "#99c794" , bg = nil , italic = false, bold = false , underline = false })
hl(0 , "NotifierIcon"      , { fg = "#E23D75" , bg = nil , italic = true , bold = false , underline = false })

hl(0 , "markdownError"     , { fg = nil , bg = "#28303a" , italic = false, bold = false , underline = false })

hl(0 , "HighlightedLineNr" , { fg = "#607070" , bg = "#384046" , italic = false, bold = false , underline = false })
hl(0 , "DimLineNr"         , { fg = "#607070" , bg = "#28303a" , italic = false, bold = false , underline = false })

hl(0 , "HighlightUndo"     , { fg = "#D57780" , bg = "#3C465A" , italic = false , bold = true  , underline = false })
hl(0 , "HighlightRedo"     , { fg = "#99c794" , bg = "#3C465A" , italic = false , bold = true  , underline = false })

hl(0 , "StatusColLineChar"   , { fg = "#304044" , bg = "#28303a" , italic = false , bold = true , underline = false })
-- End of File
