local M = {
  "hrsh7th/nvim-cmp",
  enabled = true,
  pin     = false,
  lazy    = true,
  event   = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    'rafamadriz/friendly-snippets',
    'garymjr/nvim-snippets',
    'hrsh7th/cmp-nvim-lsp-document-symbol',
    'f3fora/cmp-spell',
    {
      "L3MON4D3/LuaSnip",
      config= function ()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
      opts = {
        history = true,
        delete_check_events = "TextChanged",
      },
      keys = {
        {
          "<Tab>",
          function()
            if vim.snippet.active({ direction = 1 }) then
              vim.schedule(function()
                vim.snippet.jump(1)
              end)
              return
            end
            return "<Tab>"
          end,
          expr = true,
          silent = true,
          mode = "i",
        },
        {
          "<Tab>",
          function()
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
          end,
          expr = true,
          silent = true,
          mode = "s",
        },
        {
          "<S-Tab>",
          function()
            if vim.snippet.active({ direction = -1 }) then
              vim.schedule(function()
                vim.snippet.jump(-1)
              end)
              return
            end
            return "<S-Tab>"
          end,
          expr = true,
          silent = true,
          mode = { "i", "s" },
        },
      },
    },
    "hrsh7th/cmp-path",
    -- "hrsh7th/cmp-buffer",
    "ve5li/cmp-buffer",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lua",
    "amarakon/nvim-cmp-buffer-lines",
    {'davidsierradz/cmp-conventionalcommits', ft='gitcommit'},
    'dcampos/cmp-emmet-vim',
    "saadparwaiz1/cmp_luasnip",
    "onsails/lspkind-nvim",
    "hrsh7th/cmp-cmdline",
    "fazibear/cmp-nerdfonts",
    "dmitmel/cmp-cmdline-history",
    'buschco/nvim-cmp-ts-tag-close',
  },
}

function M.config()
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
    Array         = " " , Boolean       = " " , Class         = ' ' , Constant      = ' ' , Constructor   = ' ' ,
    Enum          = 'ℰ ' , EnumMember    = ' ' , Event         = ' ' , Field         = ' ' , File          = ' ' ,
    Folder        = ' ' , Function      = ' ' , Interface     = ' ' , Keyword       = ' ' , Method        = 'ƒ ' ,
    Module        = ' ' , Namespace     = " " , Null          = "ﳠ " , Number        = " " , Operator      = ' ' ,
    Package       = " " , Property      = ' ' , Reference     = ' ' , Snippet       = ' ' , String        = "𝓐"  ,
    Struct        = ' ' , Text          = ' ' , TypeParameter = ' ' , Unit          = ' ' , Value         = ' ' ,
    Variable      = ' ' , color         = ' ' ,
  }

  cmp.setup({
    snippet = {
      expand = function(args) require('luasnip').lsp_expand(args.body) end,
    },
    experimental = {
      ghost_text = { hl_group = "CmpGhostText" },
    },
    performance = {
      trigger_debounce_time = 50
    },
    window = {
      completion    = cmp.config.window.bordered({
        side_padding = 0,
        winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel",
        scrollbar = {
          thumb_char = "│",
          position   = "edge",
        },
        border = "rounded",
      }),
      documentation = cmp.config.window.bordered({
        winhighlight = 'Normal:CmpDocNormal',
        border       = "rounded"
      }),
    },
    view = {
      entries = {
        name = "custom",
        follow_cursor = true,
      }, -- can be "custom", "wildmenu" or "native"
      winhighlight = 'Normal:WildStatus,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
    },
    sources = {
      -- { name = 'nvim_lsp_signature_help' },
      -- { name = 'luasnip'  },
      { name = 'conventionalcommits' },
      { name = 'nerdfonts' },
      { name = 'copilot' },
      {
        name = 'luasnip',
        entry_filter = function()
          local context = require("cmp.config.context")
          return not context.in_treesitter_capture("string") and not context.in_syntax_group("String")
        end,
      },
      { name = 'nvim_lsp',
      entry_filter = function(entry)
        return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
      end,
    },
    { name = 'nvim-cmp-ts-tag-close' },
    -- { name = 'nvim_lua' },
    { name = 'path'     },
    -- { name = 'buffer-lines' },
    -- { name = 'emmet_vim' },
    { name = 'emoji'  },
    {
      name = 'buffer',
      option = {
        get_bufnrs = function()
          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
            if byte_size <= 1024 * 1024 then -- 1 Megabyte max
              bufs[buf] = true
            end
          end
          return vim.tbl_keys(bufs)
        end,},
    },
    {
      name = "spell",
      option = {
        keep_all_entries = false,
        enable_in_context = function()
          return true
        end,
        preselect_correct_word = true,
      },
    },
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },

    format = function(entry, item)
      local label = item.abbr
      local highlights_info = require("colorful-menu").cmp_highlights(entry)
      local color_item = require("nvim-highlight-colors").format(entry, { kind = item.kind })

      local truncated_label = vim.fn.strcharpart(label, 0, 50)
      if truncated_label ~= label then
        item.abbr = truncated_label .. "…"
      end

      local icon, _ = require("mini.icons").get("lsp", item.kind)
      if icon ~= nil then
        item.kind = icon
      else
        icon = icons[item.kind] or ""
      end

      icon = " " .. icon .. " "

      -- set menu source label
      item.menu = ({
        nvim_lsp = "[LSP ]",
        buffer   = "[BUF ]",
        path     = "[PATH]",
        luasnip  = "[SNIP]",
      })[entry.source.name] or ""

      color_item.kind = icon

      item.kind_hl_group = color_item.abbr_hl_group
      item.kind = color_item.kind .. color_item.abbr

      if highlights_info ~= nil then
        item.abbr_hl_group = highlights_info.highlights
        item.abbr = highlights_info.text
      end

      return item
    end,
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
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
    -- ['<C-l>'] = cmp.mapping(function(fallback)
    -- 	if cmp.visible() then
    -- 		return cmp.complete_common_string()
    -- 	end
    -- 	fallback()
    -- end, { 'i', 'c' }),
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

-- performance hack on big files
-- https://github.com/hrsh7th/nvim-cmp/issues/1522

local default_cmp_sources = cmp.config.sources({
	{ name = 'nvim_lsp' },
	{ name = 'nvim_lsp_signature_help' },
}, {
	{ name = 'vsnip' },
	{ name = 'path' }
})

local bufIsBig = function(bufnr)
	local max_filesize = 100 * 1024 -- 100 KB
	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
	if ok and stats and stats.size > max_filesize then
		return true
	else
		return false
	end
end

vim.api.nvim_create_autocmd('BufReadPre', {
	callback = function(t)
		local sources = default_cmp_sources
		if not bufIsBig(t.buf) then
			sources[#sources+1] = {name = 'treesitter', group_index = 2}
		end
	cmp.setup.buffer {
		sources = sources
	}
	end
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
local cmdline_view = {
  entries = {
    name = 'wildmenu',
    separator = ' • ',
  },
  winhighlight = 'Normal:WildStatus,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
}

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  view = cmdline_view,
  sources = {
    { name = 'buffer' },
    { name = "cmdline_history" },
    { name = "nvim_lsp_document_symbol" },
    {
      name = "spell",
      option = {
        keep_all_entries = false,
        enable_in_context = function()
          return true
        end,
        preselect_correct_word = true,
      },
    },
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  view = cmdline_view,
  sources = {
    { name = "cmdline_history" },
    { name = 'nvim_lsp_document_symbol' },
    { name = "cmdline" },
    { name = "path" },
  },
  matching = { disallow_symbol_nonprefix_matching = false },
})

  cmp.setup.filetype("namu_prompt", { enabled = false })
  cmp.setup.filetype("namu_sidebar", { enabled = false })
end

return M
