-- Copyright (c) 2026 Ratheesh<ratheeshreddy@gmail.com>. All Rights Reserved.
-- License: MiT
-- LSP related plugins

return {
  { "dchinmay2/clangd_extensions.nvim", lazy = true },
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
    enabled = true,
    event = { "LspAttach" },
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
    enabled = false,
    event = "LspAttach",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "folke/snacks.nvim", opts = { terminal = {} } },
    },
    opts = {},
    keys = {
      {
        "<leader>ca",
        function() require("tiny-code-action").code_action() end,
        mode = { "n", "x" },
        noremap = true,
        silent = true,
        desc = "Code Actions",
      },
    },
  },
  {
    "Wansmer/symbol-usage.nvim",
    enabled = false,
    event = "LspAttach",
    opts = function(_, opts)
      local function text_format(symbol)
        local res = {}

        local stacked_functions_content = symbol.stacked_count > 0 and ("+%s"):format(symbol.stacked_count) or ""

        if symbol.references then
          local usage = symbol.references <= 1 and "usage" or "usages"
          local num = symbol.references == 0 and "no" or symbol.references
          table.insert(res, { "󰌹 ", "Function" })
          table.insert(res, { ("%s %s"):format(num, usage), "Comment" })
        end

        if symbol.definition then
          if #res > 0 then
            table.insert(res, { " ", "NonText" })
          end
          table.insert(res, { "󰳽 ", "Type" })
          table.insert(res, { symbol.definition .. " defs", "Comment" })
        end

        if symbol.implementation then
          if #res > 0 then
            table.insert(res, { " ", "NonText" })
          end
          table.insert(res, { "󰡱 ", "@keyword" })
          table.insert(res, { symbol.implementation .. " impls", "Comment" })
        end

        if stacked_functions_content ~= "" then
          if #res > 0 then
            table.insert(res, { " ", "NonText" })
          end
          table.insert(res, { " ", "@keyword" })
          table.insert(res, { stacked_functions_content, "Comment" })
        end

        return res
      end
      return vim.tbl_deep_extend("force", opts or {}, {
        text_format = text_format,
        definition = { enabled = true },
        implementation = { enabled = true },
        symbol_filter = function(ctx)
          return function(symbol)
            if ctx.method == "textDocument/references" then
              return string.find(symbol.uri, "test") == nil
            else
              return true
            end
          end
        end,
      })
    end,
  },
  {
    "roobert/action-hints.nvim",
    enabled = false,
    event = { "LspAttach", "BufReadPost" },
    config = function()
      require("action-hints").setup({
        use_virtual_text = true,
        template = {
          definition = { text = " ⊛", color = "ActionHintDef" },
          references = { text = " ↱%s", color = "ActionHintRef" },
        },
      })
    end,
  },
}
-- End of File
