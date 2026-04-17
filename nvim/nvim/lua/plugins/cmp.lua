local M = {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },

  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "ve5li/cmp-buffer",
    "hrsh7th/cmp-emoji",
    "f3fora/cmp-spell",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
    "onsails/lspkind-nvim",
    "fazibear/cmp-nerdfonts",
    {'davidsierradz/cmp-conventionalcommits', ft='gitcommit'},
    "hrsh7th/cmp-cmdline",
    "dmitmel/cmp-cmdline-history",
  },
}

M.enabled = true

function M.config()

  local cmp = require("cmp")
  local types = require("cmp.types")
  local luasnip = require("luasnip")
  local lspkind = require("lspkind")
  local ok_clangd, clangd_cmp = pcall(require, "clangd_extensions.cmp_scores")

  require("luasnip.loaders.from_vscode").lazy_load()

  --------------------------------------------------
  -- helpers
  --------------------------------------------------
  luasnip.config.setup({
    region_check_events = "CursorMoved",
    delete_check_events = "TextChanged",
  })

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    if col == 0 then return false end
    local text = vim.api.nvim_buf_get_lines(0, line-1, line, true)[1]
    return text:sub(col, col):match("%s") == nil
  end

  --------------------------------------------------
  -- cmp setup
  --------------------------------------------------

  cmp.setup({

    -- preselect = cmp.PreselectMode.None,

    completion = {
      completeopt = "menu,menuone,noinsert,noselect",
    },

    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },

    experimental = {
      ghost_text = true,
    },

    window = {
      completion = cmp.config.window.bordered({
        side_padding = 0,
        winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel",
        scrollbar = {
          thumb_char = "│",
          position   = "edge",
        },
        border = "single",
      }),
      documentation = cmp.config.window.bordered({
        winhighlight = 'Normal:CmpDocNormal',
        border       = "rounded"
      }),
    },

    view = {
      entries = {
        name = "custom",
        selection_order = "near_cursor",
        follow_cursor = true,
      },
      winhighlight = 'Normal:WildStatus,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
    },
    --------------------------------------------------
    -- keymaps
    --------------------------------------------------

    mapping = cmp.mapping.preset.insert({

      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Insert }),
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert }),

      ["<C-d>"] = cmp.mapping.scroll_docs(4),
      ["<C-u>"] = cmp.mapping.scroll_docs(-4),

      ["<C-Space>"] = cmp.mapping.complete(),

      ["<BS>"] = cmp.mapping(function(fallback)
        fallback()
        vim.schedule(function()
          if has_words_before() then
            cmp.complete()
          end
        end)
      end, { "i" }),

      ["<CR>"] = cmp.mapping(function(fallback)
        if cmp.visible() and cmp.get_selected_entry() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert, select = true })
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert, select = true })
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<C-l>"] = cmp.mapping(function(fallback)
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<C-h>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),

    --------------------------------------------------
    -- sources
    --------------------------------------------------

    sources = cmp.config.sources({
      { name = "copilot",   priority = 1000 },
      { name = "path",      priority = 999  },
      { name = "nvim_lsp",  priority = 998  },
      { name = 'nerdfonts', priority = 997  },
      { name = "luasnip",   priority = 996  },

    }, {
        {
          name = 'buffer', priority = 1000,
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
            end,
          },
        },
        { name = "emoji" },
        { name = "spell" },
      }),

    --------------------------------------------------
    -- formatting
    --------------------------------------------------

    formatting = {
      fields = { 'icon', 'abbr', 'kind', 'menu' },
      format = function(entry, vim_item)
        local kind = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = {
            menu = 50, -- leading text (labelDetails)
            abbr = 50, -- actual suggestion item
          },
          ellipsis_char = "…",
          show_labelDetails = true,
        })(entry, vim_item)

        -- Add source labels
        local source_map = {
          nvim_lsp = "[LSP ]",
          luasnip  = "[SNIP]",
          buffer   = "[BUF ]",
          path     = "[PATH]",
          copilot  = "[ AI ]",
        }

        kind.menu = source_map[entry.source.name] or ("[" .. entry.source.name .. "]")

        --[[ local highlights_info = require("colorful-menu").cmp_highlights(entry)
        if highlights_info ~= nil then
          vim_item.abbr_hl_group = highlights_info.highlights
          vim_item.abbr = highlights_info.text
        end ]]

        -- Add fancy separators
        kind.icon = " " .. kind.icon .. ""
        kind.kind = "" .. kind.kind .. ""
        kind.abbr = "" .. kind.abbr .. ""

        return kind
      end,
    },
    --------------------------------------------------
    -- sorting
    --------------------------------------------------

    sorting = {
      priority_weight = 2,
      comparators = vim.tbl_filter(function(v) return v ~= nil end, {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        ok_clangd and clangd_cmp or nil,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        cmp.config.compare.kind,
        cmp.config.compare.length,
        cmp.config.compare.order,
      }),
    },

  })

  --------------------------------------------------
  -- big file protection
  --------------------------------------------------

  local function is_big(buf)
    local max = 100 * 1024
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
    return ok and stats and stats.size > max
  end

  vim.api.nvim_create_autocmd("BufReadPre", {
    callback = function(args)
      if is_big(args.buf) then
        cmp.setup.buffer({
          sources = {
            { name = "nvim_lsp" },
            { name = "path" },
          }
        })
      end
    end,
  })


  local cmdline_view = {
    entries = {
      name = 'wildmenu',
      separator = ' • ',
    },
    winhighlight = 'Normal:WildStatus,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
  }
  --------------------------------------------------
  -- search completion
  --------------------------------------------------

  cmp.setup.cmdline({ "/", "?" }, {
    mapping    = cmp.mapping.preset.cmdline(),
    view       = cmdline_view,
    completion = { keyword_length = 1 },
    sources    = cmp.config.sources({
      { name = "buffer",          priority = 1000 },
    }, {
      { name = "cmdline_history", priority = 500  },
    }),
  })

  --------------------------------------------------
  -- command completion
  --------------------------------------------------

  cmp.setup.cmdline(":", {
    mapping    = cmp.mapping.preset.cmdline(),
    view       = cmdline_view,
    completion = { keyword_length = 1 },
    sources    = cmp.config.sources({
      { name = "path",    priority = 2000 },
      { name = "cmdline", priority = 1000 },
    }, {
      { name = "cmdline_history",           priority = 750 },
      { name = "nvim_lsp_document_symbol",  priority = 500 },
      {
        name = "spell",
        priority = 250,
        option = {
          keep_all_entries      = false,
          enable_in_context     = function() return true end,
          preselect_correct_word = true,
        },
      },
    }),
  })

  --------------------------------------------------
  -- filetype overrides
  --------------------------------------------------

  cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
      { name = "conventionalcommits" },
      { name = "nvim_lsp" },
      { name = "luasnip" },
    }, {
      { name = "buffer" },
    }),
  })

  cmp.setup.filetype("namu_prompt", { enabled = false })
  cmp.setup.filetype("namu_sidebar", { enabled = false })

end

return M
