require("tung.remap")
require("tung.plugins-setup")
require("tung.plugins.telescope")
require("tung.plugins.treesitter")
require("tung.plugins.lualine")
require("tung.plugins.scope")
require("tung.plugins.tabline")
require("tung.plugins.nvimtree")
local opt = vim.opt

vim.o.showtabline = 2
-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false -- disable line wrapping

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- set colorscheme to nightfly with protected call
local status, _ = pcall(vim.cmd, "colorscheme tokyonight")
if not status then
  print("Colorscheme not found!") -- print error if colorscheme not installed
  return
end

