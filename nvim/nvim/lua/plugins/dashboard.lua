local M = {
  'glepnir/dashboard-nvim',
  enabled = false,
  event = 'VimEnter',
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
}


function M.config()
  require('dashboard').setup {
    theme = 'hyper',
    config = {
      week_header = {
        enable = false,
      },
      shortcut = {
        { desc = ' Update', group = '@property', action = 'Lazy update', key = 'u' },
        {
          desc = ' Files',
          group = 'Label',
          action = 'Telescope find_files',
          key = 'f',
        },
        {
          desc = ' Apps',
          group = 'DiagnosticHint',
          action = 'Telescope app',
          key = 'a',
        },
        {
          desc = ' dotfiles',
          group = 'Number',
          action = 'Telescope dotfiles',
          key = 'd',
        },
      },
    },
    hide = {
      statusline = false,
      tabline    = false,
      winbar     = false,
    },
    packages = {
      enable = true
    },
    project = {
      limit = 5,
      icon = 'your icon',
      label = '',
      action = 'Telescope find_files cwd='
    },
    mru = {
      limit = 5,
      icon = 'your icon',
      label = '',
    },
    footer = {},
  }
end

return M
