local Util = require("util")

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },

    dependencies = {
      "mason-core/mason.nvim",
      "mason-core/mason-lspconfig.nvim",

      { "ray-x/lsp_signature.nvim", event = "InsertEnter" },

      {
        "rachartier/tiny-inline-diagnostic.nvim",
        enabled = false,
        event = "VeryLazy",
        config = function()
          require("tiny-inline-diagnostic").setup({
            preset = "amongus",
          })
        end,
      },
      {
        "Chaitanyabsprip/fastaction.nvim",
        enabled = false,
        opts = {},
        keys = {
          {
            "<leader>ca",
            function() require("fastaction").code_action() end,
            desc = "Code Actions",
          },
        },
      },
      {
        "rachartier/tiny-code-action.nvim",
        enabled = true,
        event = "LspAttach",
        dependencies = {
          {"nvim-lua/plenary.nvim"},
          { "folke/snacks.nvim", opts = { terminal = {}, } }
        },
        opts = {},
        vim.keymap.set({ "n", "x" }, "<leader>ca", function()
          require("tiny-code-action").code_action()
        end, { noremap = true, silent = true })
      }
    },

    config = function()

      ----------------------------------------------------------------
      -- Diagnostics
      ----------------------------------------------------------------
      ---

      vim.diagnostic.config({
        virtual_text  = { current_line = true },
        virtual_lines = false,

        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰧞",
            [vim.diagnostic.severity.WARN]  = "󰧞",
            [vim.diagnostic.severity.INFO]  = "󰧞",
            [vim.diagnostic.severity.HINT]  = "󰧞",
          },
        },
        underline        = true,
        update_in_insert = false,
        severity_sort    = true,
      })

      vim.keymap.set("n", "<f4>", function()
        local cfg = vim.diagnostic.config()

        if cfg.virtual_lines then
          vim.diagnostic.config({
            virtual_lines = false,
            virtual_text = {
              current_line = true,
              spacing      = 2,
              prefix       = "●",
            },
            underline        = true,
            update_in_insert = false,
            severity_sort    = true,
          })
        else
          vim.diagnostic.config({
            virtual_lines = {
              current_line = true,
              spacing      = 2,
              prefix       = "●",
            },
            virtual_text     = false,
            underline        = true,
            update_in_insert = false,
            severity_sort    = true,
          })
        end
      end, { desc = "Toggle diagnostic style" })

      ----------------------------------------------------------------
      -- Capabilities
      ----------------------------------------------------------------

      local capabilities = vim.lsp.protocol.make_client_capabilities()

      local ok_cmp, cmp = pcall(require, "cmp_nvim_lsp")
      if ok_cmp then
        capabilities = cmp.default_capabilities(capabilities)
      end

      local ok_blink, blink = pcall(require, "blink.cmp")
      if ok_blink then
        capabilities = blink.get_lsp_capabilities(capabilities)
      end

      ----------------------------------------------------------------
      -- Global LSP config
      ----------------------------------------------------------------

      vim.lsp.config("*", {
        root_markers = { ".git", ".hg", ".svn", ".root" },

        capabilities = vim.tbl_deep_extend("force", capabilities, {
          textDocument = {
            semanticTokens = {
              multilineTokenSupport = true,
            },
          },
        }),
      })

      ----------------------------------------------------------------
      -- Inlay hints
      ----------------------------------------------------------------

      Util.lsp.on_attach(function(client, buffer)
        if client:supports_method("textDocument/inlayHint") then
          Util.toggle.inlay_hints(buffer, true)
        end
      end)

      ----------------------------------------------------------------
      -- clangd
      ----------------------------------------------------------------

      vim.lsp.config("clangd", {

        filetypes = { "c", "cpp" },

        root_markers = {
          ".clang-format",
          "compile_commands.json",
        },

        cmd = {
          "clangd",
          "--clang-tidy",
          "--background-index",
          "--completion-style=detailed",
          "--header-insertion=iwyu",
          "--header-insertion-decorators",
          "--all-scopes-completion",
          "--cross-file-rename",
          "--pch-storage=memory",
        },

        capabilities = {
          textDocument = {
            completion = {
              completionItem = {
                snippetSupport = true,
              },
            },
          },
        },
      })

      ----------------------------------------------------------------
      -- lua_ls
      ----------------------------------------------------------------

      vim.lsp.config("lua_ls", {

        root_dir = function(bufnr, on_dir)
          if not vim.fn.bufname(bufnr):match("%.txt$") then
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
              globals = { "vim", "Snacks" },
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
      })

      vim.lsp.config("pyright", {})
      vim.lsp.config("rust_analyzer", {})

    end,
  }
}
