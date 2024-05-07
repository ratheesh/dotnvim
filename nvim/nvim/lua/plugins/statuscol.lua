return {
{
    'luukvbaal/statuscol.nvim',
    branch = '0.10',
    enabled = true,
    event = { "BufReadPre" },
    config = function()
      local builtin = require 'statuscol.builtin'
      require('statuscol').setup {
        -- setopt = true,
        relculright = false,
        clickhandlers = {
          Lnum = builtin.gitsigns_click,
        },
        segments = {
          {
            sign = {
              name = { '.*' },
              namespace = { '.*' },
              -- namespace = { ".*diagnostic.*" },
              -- name = { "todo%-sign.*" }, -- WARN: escape the dash `-`
              maxwidth = 1,
              -- colwidth = 2,
              auto = true,
              wrap = true,
            },
          },
          {
            sign = {
              namespace = { "diagnostic" },
              maxwidth = 1,
              -- colwidth = 2,
              auto = true,
              wrap = true,
            }
          },
          {
            text = { builtin.lnumfunc },
            colwidth = 1,
            click = 'v:lua.ScLa',
          },
          {
            sign = {
              name = { 'GitSigns*' },
              namespace = { 'gitsigns' },
              colwidth = 1,
              fillchar = "│",
              fillcharhl = 'StatusColLineChar',
            },
            click = 'v:lua.ScSa',
          },
          {
            text = { builtin.foldfunc, },
            hl = 'FoldColumn',
            wrap = true,
            colwidth = 1,
            click = 'v:lua.ScFa',
          },
        },
      }
    end,
  },
}
