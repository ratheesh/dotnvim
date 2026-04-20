-- Copyright (c) 2024 Ratheesh <ratheeshreddy@gmail.com>
-- License: MiT
-- mini.clue configuration

return {
  "echasnovski/mini.clue",
  version = false,
  event = "VeryLazy",
  config = function()
    local MiniClue = require("mini.clue")
    MiniClue.setup({
      triggers = {
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },
        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },
        { mode = "i", keys = "<C-x>" },
        { mode = "n", keys = "<C-w>" },
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },
        { mode = "n", keys = "[" },
        { mode = "n", keys = "]" },
      },
      clues = {
        MiniClue.gen_clues.builtin_completion(),
        MiniClue.gen_clues.g(),
        MiniClue.gen_clues.marks(),
        MiniClue.gen_clues.registers(),
        MiniClue.gen_clues.windows(),
        MiniClue.gen_clues.z(),
        -- <Leader> group labels
        { mode = "n", keys = "<Leader>a",  desc = "+ai/claude" },
        { mode = "n", keys = "<Leader>b",  desc = "+buffers" },
        { mode = "n", keys = "<Leader>c",  desc = "+code/lsp" },
        { mode = "n", keys = "<Leader>f",  desc = "+files" },
        { mode = "n", keys = "<Leader>g",  desc = "+git" },
        { mode = "n", keys = "<Leader>m",  desc = "+make/cmake" },
        { mode = "n", keys = "<Leader>mS", desc = "+splitjoin" },
        { mode = "n", keys = "<Leader>s",  desc = "+search" },
        { mode = "n", keys = "<Leader>t",  desc = "+theme" },
        { mode = "x", keys = "<Leader>a",  desc = "+ai/claude" },
        { mode = "x", keys = "<Leader>c",  desc = "+code/lsp" },
        { mode = "x", keys = "<Leader>g",  desc = "+git" },
        { mode = "x", keys = "<Leader>m",  desc = "+make/cmake" },
      },
      window = {
        delay = 700,
        config = {
          border = "rounded",
          width  = "auto",
        },
        scroll_down = "<C-d>",
        scroll_up   = "<C-u>",
      },
    })
  end,
}
-- End of File
