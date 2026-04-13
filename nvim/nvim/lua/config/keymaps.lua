-- Copyright (c) 2026 Ratheesh. All Rights Reserved.
-- License: MiT

-- Add any additional keymaps here
-- Keymaps are automatically loaded on the VeryLazy event

-- works only with NVIM 0.7+
local function map(mode, new_keys, to_do, options)
  local keymap = vim.keymap.set
  local default_options = {
    silent = true,
  }
  if options then
    default_options = vim.tbl_extend('force', default_options, options)
  end
  keymap(mode, new_keys, to_do, default_options)
end

map({ "i" }, "<S-CR>", "<C-o>o", { expr = true, silent = true })
map({ "n", "x" }, "<Leader>;", ":", { expr = true, silent = true })

map({ "n" }, "<CR>", "<cmd>call append(line('.'), '')<CR>", {  silent = true })
map({ "n" }, "<A-o>", "<cmd>call append(line('.')-1, '')<CR>", {  silent = true })

map({ "n" }, "<F2>", "<cmd>echomsg expand('%:p')<CR>", {  silent = true })

map({ "x", "o" }, "v", function()
  local ok, parser = pcall(vim.treesitter.get_parser, vim.api.nvim_get_current_buf())
  if ok and parser then
    local ok_ts, ts_select = pcall(require, "vim.treesitter._select")
    if ok_ts then
      ts_select.select_child(vim.v.count1)
      return
    end
  end
  vim.lsp.buf.selection_range(-vim.v.count1)
end, { desc = "Select child (inside)" })

map({ "x", "o", "o" }, "V", function()
  local ok, parser = pcall(vim.treesitter.get_parser, vim.api.nvim_get_current_buf())
  if ok and parser then
    local ok_ts, ts_select = pcall(require, "vim.treesitter._select")
    if ok_ts then
      ts_select.select_parent(vim.v.count1)
      return
    end
  end
  vim.lsp.buf.selection_range(vim.v.count1)
end, { desc = "Select parent (outside)" })

-- Select previously pasted text
map("n", "gV", "`[V`]", { desc = "Select previously pasted text" })

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

--keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- quit
map("n", "<leader>x", "<cmd>qa<cr>", { desc = "Quit all" })
map("n", "<A-x>", "<cmd>xall<cr>", { desc = "Save All and exit" })

-- luasnip jump during the pmenu
map({ "i", "s" }, "<C-l>", function()
  local ok, luasnip = pcall(require, 'luasnip')
  if ok then luasnip.jump(1) end
end)
map({ "i", "s" }, "<C-h>", function()
  local ok, luasnip = pcall(require, 'luasnip')
  if ok then luasnip.jump(-1) end
end)

-- When lines are on, text is off. Text on, lines off. Minimize clutter.
map("n", "<F4>", function()
  local config = vim.diagnostic.config()
  local virtual_lines = config.virtual_lines
  local virtual_text = config.virtual_text
  vim.diagnostic.config({
    virtual_lines = not virtual_lines,
    virtual_text = not virtual_text,
  })
end, { desc = 'Toggle diagnostic lines' })
-- End of File
