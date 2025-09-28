local Util = require("util")
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-core/mason.nvim",
      "mason-core/mason-lspconfig.nvim",
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
        enabled = true,
        event = "VeryLazy",
        config = function()
          require('tiny-inline-diagnostic').setup({
            preset = "amongus",
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
          'oribarilan/lensline.nvim',
          enabled = true,
          event = 'LspAttach',
          config = function()
            require("lensline").setup({
              -- Profile definitions, first is default
              profiles = {
                {
                  name = "basic",
                  providers = {
                    breakdown = true,
                    show_zero = true,
                    include = { "refs", "defs", "impls" },
                    { name = "references", enabled = true },
                    { name = "last_author", enabled = true },
                    { name = "diagnostics", enabled = true, min_level = "HINT" },
                  },
                  style = {
                    prefix       = ' ',
                    use_nerdfont = true,
                    separator    = " • ",
                    render       = "all",
                    placement    = "inline"
                  }
                },
                {
                  name = "informative",
                  providers = {
                    { name = "references", enabled = true },
                    { name = "diagnostics", enabled = true, min_level = "HINT" },
                    { name = "complexity", enabled = true }
                  },
                  style = { render = "focused", placement = "inline" }
                }
              },
            })
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
    opts = function(_,opts)
      local ret = {
        -- options for vim.diagnostic.config()
        diagnostics = {
          underline = true,
          update_in_insert = false,
          -- virtual_text = {
          --   spacing = 4,
          --   source = "if_many",
          --   -- prefix = "󰧞",
          --   prefix = "icons",
          -- },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = '󰧞',
              [vim.diagnostic.severity.WARN]  = '󰧞',
              [vim.diagnostic.severity.HINT]  = '󰧞',
              [vim.diagnostic.severity.INFO]  = '󰧞',
            },
          },
        },
        -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the inlay hints.
        inlay_hints = {
          enabled = true,
          exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
        },
        -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the code lenses.
        codelens = {
          enabled = false,
        },
        -- add any global capabilities here
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
        -- options for vim.lsp.buf.format
        -- `bufnr` and `filter` is handled by the LazyVim formatter,
        -- but can be also overridden when specified
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
            -- ---@type LazyKeysSpec[]
            -- keys = {},
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false,
                },
                codeLens = {
                  enable = true,
                },
                completion = {
                  callSnippet = "Replace",
                },
                doc = {
                  privateName = { "^_" },
                },
                hint = {
                  enable = true,
                  setType = false,
                  paramType = true,
                  paramName = "Disable",
                  semicolon = "Disable",
                  arrayIndex = "Disable",
                },
              },
            },
          },
        },
        -- you can do any additional lsp server setup here
        -- return true if you don't want this server to be setup with lspconfig
        ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
        setup = {
          -- example to setup with typescript.nvim
          -- tsserver = function(_, opts)
            --   require("typescript").setup({ server = opts })
            --   return true
            -- end,
            -- Specify * to use this function as a fallback for any server
            -- ["*"] = function(server, opts) end,
          },
        }
        return ret
    end,

    ---@param opts PluginLspOpts
    config = function(_, opts)
      local register_capability = vim.lsp.handlers["client/registerCapability"]

      vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
        local ret = register_capability(err, res, ctx)
        -- local client_id = ctx.client_id
        -- local client = vim.lsp.get_client_by_id(client_id)
        -- local buffer = vim.api.nvim_get_current_buf()
        -- require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
        return ret
      end

      if opts.inlay_hints.enabled then
        Util.lsp.on_attach(function(client, buffer)
          if client:supports_method("textDocument/inlayHint") then
            Util.toggle.inlay_hints(buffer, true)
          end
        end)
      end

      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
        or function() end
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      -- local servers = opts.servers
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

      -- Global settings
      vim.lsp.config('*', {
        root_markers = { '.git', '.hg', '.svn', '.root' },
        capabilities = {
          textDocument = {
            semanticTokens = {
              multilineTokenSupport = true,
            }
          }
        },
      })

      -- clangd
      vim.lsp.config('clangd', {
        root_markers = { '.clang-format', 'compile_commands.json' },
        filetypes = { 'c', 'cpp' },
        cmd = {
          'clangd',
          '--clang-tidy',
          '--background-index',
          '--offset-encoding=utf-8',
          '--completion-style=detailed',
          '--header-insertion=iwyu',
          '--header-insertion-decorators',
        },
        capabilities = {
          textDocument = {
            completion = {
              completionItem = {
                snippetSupport = true,
              }
            }
          }
        }
      })

      -- lua_ls
      vim.lsp.config('lua_ls', {
        root_dir = function(bufnr, on_dir)
          if not vim.fn.bufname(bufnr):match('%.txt$') then
            on_dir(vim.fn.getcwd())
          end
        end,
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
      })

    end,
  },
}
