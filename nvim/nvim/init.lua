vim.opt.rtp:append(vim.fn.stdpath "config" .. "/config")

require("config.settings")
require("config/lazy_bootstrap")

require("lazy").setup("plugins", {
 defaults = { lazy = true },
 install = { colorscheme = { "tokyonight" } },
 ui = {
	 border = 'rounded',
 },
 checker = { enabled = true },
 performance = {
  rtp = {
   disabled_plugins = {
    "gzip",
    "matchit",
    "matchparen",
    "netrwPlugin",
    "tarPlugin",
    "tohtml",
    "tutor",
    "zipPlugin",
   },
  },
 },
 -- debug = true,
})

require("config.colors")
vim.api.nvim_create_autocmd("User", {
 pattern = "VeryLazy",
 callback = function()
  require("config.keymaps")
  require("config.commands")
 end,
})

-- don't load the plugins below
local builtins = {
 "gzip",
 "zip",
 "zipPlugin",
 "fzf",
 "tar",
 "tarPlugin",
 "getscript",
 "getscriptPlugin",
 "vimball",
 "vimballPlugin",
 "2html_plugin",
 "matchit",
 "matchparen",
 "logiPat",
 "rrhelper",
 "netrw",
 "netrwPlugin",
 "netrwSettings",
 "netrwFileHandlers",
}

for _, plugin in ipairs(builtins) do
 vim.g["loaded_" .. plugin] = 1
end
-- End of File
