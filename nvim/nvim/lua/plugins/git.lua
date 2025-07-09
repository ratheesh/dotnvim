-- Copyright (c) 2023 Ratheesh <ratheeshreddy@gmail.com>
-- License: MIT
-- Gitsigns plugin config

return {
  {
    "rhysd/committia.vim",
    enabled = false,
    lazy = false, -- just in case
    init = function()
      vim.g.committia_open_only_vim_starting = 0
      vim.g.committia_use_singlecolumn       = "always"
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    opts = {
      signs = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "│" },
        topdelete    = { text = "" },
        changedelete = { text = "│" },
        untracked    = { text = "│" },
      },
      signs_staged = {
        add          = { text = "┃" },
        change       = { text = "┃" },
        delete       = { text = "━" },
        topdelete    = { text = "" },
        changedelete = { text = "┃" },
      },
      diff_opts = {
        internal = true,
      },
      preview_config = {
        border   = 'rounded',
        style    = 'minimal',
        relative = 'cursor',
        row      = 0,
        col      = 1
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")
        map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
        map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>gp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>gB", function() gs.blame() end, "Blame Buffer")
        map("n", "<leader>gd", gs.diffthis, "Diff This")
        map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ig", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
        vim.api.nvim_create_user_command("Stage", function(t) gs.stage_hunk({ t.line1, t.line2 }) end, { range = true })
        vim.api.nvim_create_user_command("Reset", function(t) gs.reset_hunk({ t.line1, t.line2 }) end, { range = true })
      end,
    },
  },
  {
    'akinsho/git-conflict.nvim',
    enabled = true,
    event   = "BufReadPre",
    config  = true,
  }
}

-- End of File
