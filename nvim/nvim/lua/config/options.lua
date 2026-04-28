-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- This file is automatically loaded by plugins.core

local opt = vim.opt
local o = vim.o

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.autoformat = true
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

o.autowrite = true
o.clipboard = "unnamedplus"
o.completeopt = "menu,menuone,noselect"
o.conceallevel = 3
o.confirm = true
o.cmdheight = 1
o.cursorline = true
o.expandtab = true
o.formatoptions = "jcroqlnt"
o.grepformat = "%f:%l:%c:%m"
o.grepprg = "rg --vimgrep"
o.ignorecase = true
o.shada = "%,<50,'25,/25,:20,s20,h,f1"
o.inccommand = "nosplit"
o.laststatus = 3
o.list = true
o.mouse = "a"
o.number = true
o.pumblend = 0
o.pumheight = 10
o.relativenumber = true
o.scrolloff = 5
o.shiftround = true
o.shiftwidth = 4
o.showmode = false
o.sidescrolloff = 8
o.colorcolumn = "81"
o.signcolumn = "yes"
o.smartcase = true
o.smartindent = false
o.spell = true
o.spelllang = "en"
o.splitbelow = true
o.splitkeep = "screen"
o.splitright = true
o.tabstop = 4
o.termguicolors = true
o.timeoutlen = 500
o.undofile = true
o.undoreload = 200
o.undolevels = 1000
o.updatetime = 250
o.virtualedit = "block"
o.wildmode = "longest:full,full"
o.winminwidth = 5
o.wrap = true
o.smoothscroll = true
o.showbreak = '↪ '

opt.listchars = {
  trail = "•",
  tab = "  ",
  extends = "",
  precedes = ""
}

opt.fillchars = {
  foldopen = "▼",
  foldclose = "▶",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
  stl = "─",
}

opt.guicursor = "n:block-nCursor-blinkon0,i-ci:ver30-iCursor-blinkon0,v-ve:block-vCursor-blinkon0,o:hor30-oCursor-blinkon0,r-cr:block-rCursor-blinkon0"

vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

vim.g.markdown_recommended_style = 0

-- End of File