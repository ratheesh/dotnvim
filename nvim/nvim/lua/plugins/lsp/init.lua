local Util = require("util")
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      { 'ray-x/lsp_signature.nvim', event = 'InsertEnter' },
      {
        "roobert/action-hints.nvim",
        enabled = false,
        config = function()
          require("action-hints").setup({
            template = {
              definition = { text = " ⊛", color = "#add8e6" },
              references = { text = " ↱%s", color = "#ff6666" },
            },
            use_virtual_text = true,
          })
        end,
      },
      {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        config = function()
          require('tiny-inline-diagnostic').setup({
            preset = "modern",
          })
        end
      },
      {
        'simrat39/symbols-outline.nvim',
        enabled = false,
        cmd = 'SymbolOutline',
        config = function()
          require("symbols-outline").setup()
        end,
      },
      {
        "oskarrrrrrr/symbols.nvim",
        enabled = false,
        config = function()
          local r = require("symbols.recipes")
          require("symbols").setup(r.DefaultFilters, r.AsciiSymbols, {
            -- custom settings here
            -- e.g. hide_cursor = false
          })
          vim.keymap.set("n", "<leader>s", "<cmd>Symbols<CR>")
          vim.keymap.set("n", "<leader>S", "<cmd>SymbolsClose<CR>")
        end
      },
      {
        'Chaitanyabsprip/fastaction.nvim',
        enabled = true,
        opts = {},
        keys = {
          { "<leader>ca", function()  require("fastaction").code_action() end, desc = "Buffers" },
        },
      },
      {
        'nvimdev/lspsaga.nvim',
        enabled = false,
        after = "nvim-lspconfig",
        config = function()
          require('lspsaga').setup({})
        end,
        dependencies = {
          'nvim-treesitter/nvim-treesitter',
          'nvim-tree/nvim-web-devicons',
        }
      },
      {
        "aznhe21/actions-preview.nvim",
        enabled = false,
        event = "LspAttach",
        config = function()
          vim.keymap.set({ "v", "n" }, "gf", require("actions-preview").code_actions)
        end,
      },
    },
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        virtual_text = false,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
        -- signs = true,
      -- local lsp_signs = { Error = "●", Warn = "●", Hint = "", Info = "" }
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '●',
            [vim.diagnostic.severity.WARN]  = '●',
            [vim.diagnostic.severity.HINT]  = '',
            [vim.diagnostic.severity.INFO]  = '',
          },
          linehl = {
            -- [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
          },
          numhl = {
            -- [vim.diagnostic.severity.WARN] = 'WarningMsg',
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = false,
      },
      inlay_hints = {
        enabled = true,
      },

      capabilities = {},

      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP Server Settings
      ---@type lspconfig.options
      servers = {
        lua_ls = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          -- Use this to add any additional keymaps
          -- for specific lsp servers
          -- keys = {},
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
              diagnostics = {
                globals = {'vim', 'Snacks'},
              },
            },
          },
        },
      },
      setup = {
      },
    },
    ---@param opts PluginLspOpts
    config = function(_, opts)
      local register_capability = vim.lsp.handlers["client/registerCapability"]

      vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
        local ret = register_capability(err, res, ctx)
        local client_id = ctx.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        local buffer = vim.api.nvim_get_current_buf()
        -- require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
        return ret
      end

      if opts.inlay_hints.enabled then
        Util.lsp.on_attach(function(client, buffer)
          if client.supports_method("textDocument/inlayHint") then
            Util.toggle.inlay_hints(buffer, true)
          end
        end)
      end

      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
        or function() end
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local has_blink, blink_lsp = pcall(require, "blink.cmp")
      local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      has_cmp and cmp_nvim_lsp.default_capabilities() or {},
      has_blink and blink_lsp.get_lsp_capabilities() or {},
      opts.capabilities or {}
  )

      -- local capabilities = {}
      if has_blink then
        capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
      end

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      -- get all the servers that are available through mason-lspconfig
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      if have_mason then
        mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
      end
    end,
  },
  {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        opts = {
            pip = {
                upgrade_pip = true,
            },
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
            local utils = require("utils")
            local mr = require("mason-registry")
            local packages = utils.mason_packages
            local function ensure_installed()
                for _, package in ipairs(packages) do
                    local p = mr.get_package(package)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end
            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },
}
