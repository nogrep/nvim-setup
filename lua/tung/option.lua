-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- tabs & indentation
vim.o.tabstop = 2 -- 2 spaces for tabs (prettier default)
vim.o.shiftwidth = 2 -- 2 spaces for indent width
vim.o.expandtab = true -- expand tab to spaces
vim.o.autoindent = true -- copy indent from current line when starting new one

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'


-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.cursorline = true
