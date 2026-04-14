-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- This file is automatically loaded by lazyvim.config.init.

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  command = "checktime",
})

-- Enable relative number only in non-insert mode
local cursorGrp = vim.api.nvim_create_augroup('cursorGrp', { clear = true })
vim.api.nvim_create_autocmd(
{ 'InsertLeave', 'WinEnter' },
{ pattern = '*', command = 'set relativenumber', group = cursorGrp })

vim.api.nvim_create_autocmd(
{ 'InsertEnter', 'WinLeave' },
{ pattern = '*', command = 'set norelativenumber', group = cursorGrp })

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit", "gitrebase" }
    local buf = event.buf
    if vim.list_contains(exclude, vim.bo[buf].filetype) then
      vim.schedule(function()
        pcall(vim.api.nvim_win_set_cursor, 0, { 1, 0 })
      end)
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- gitcommit: set colorcolumn and position cursor at top
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("gitcommit"),
  pattern = { "gitcommit" },
  callback = function()
    vim.opt_local.colorcolumn = "73"
    vim.schedule(function()
      pcall(vim.api.nvim_win_set_cursor, 0, { 1, 0 })
    end)
  end,
})

-- Toggle inline hints on a shortcut
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf ---@type number
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or not client:supports_method('textDocument/inlayHint') then
      return
    end
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    vim.keymap.set('n', '<leader>i', function()
      vim.lsp.inlay_hint.enable(
        not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
        { bufnr = bufnr }
      )
    end, { buffer = bufnr, noremap = true, silent = true })
  end,
})

-- Fix cursor jumps upon tab after non completion of previous snippet
vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = '*',
  callback = function()
    if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i') then
      local ok, luasnip = pcall(require, 'luasnip')
      if ok and luasnip.session.current_nodes[vim.api.nvim_get_current_buf()] and not luasnip.session.jump_active then
        luasnip.unlink_current()
      end
    end
  end
})

-- Fix conceallevel for json & help files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "json", "jsonc" },
  callback = function()
    vim.wo.spell = false
    vim.wo.conceallevel = 0
  end,
})

-- Clear search highlight on cursor move; restore when using search keys (n/N/*/#/?//)
local search_ns = vim.api.nvim_create_namespace('auto_hlsearch')
local _search_key_pressed = false
vim.on_key(function(char)
  if vim.fn.mode() == 'n' then
    if vim.list_contains({ 'n', 'N', '*', '#', '?', '/' }, vim.fn.keytrans(char)) then
      _search_key_pressed = true
    end
  end
end, search_ns)

vim.api.nvim_create_autocmd('CursorMoved', {
  group = augroup('auto_hlsearch'),
  callback = function()
    if _search_key_pressed then
      _search_key_pressed = false
      vim.opt.hlsearch = true
    else
      vim.opt.hlsearch = false
    end
  end,
})

-- Filetype-specific indent widths (global default: sw=4 ts=4 et)
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("indent"),
  pattern = {
    "css", "html", "javascript", "javascriptreact",
    "json", "jsonc", "lua", "markdown",
    "scss", "toml", "typescript", "typescriptreact",
    "vim", "xml", "yaml",
  },
  callback = function()
    vim.opt_local.shiftwidth  = 2
    vim.opt_local.tabstop     = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- End of File
