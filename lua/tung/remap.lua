vim.g.mapleader = " "
local keymap = vim.keymap
keymap.set("n", "<leader>pv", vim.cmd.Ex)  

local builtin = require('telescope.builtin')
keymap.set('n', '<leader>ff', builtin.find_files, {})
keymap.set('n', '<leader>fg', builtin.live_grep, {})
keymap.set('n', '<leader>fb', builtin.buffers, {})


keymap.set('n', '<leader>e', ":NvimTreeToggle<CR>")

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window


-- window movement
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-l>", "<C-w>l")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<leader>c", ":conf q<CR>")
keymap.set("n", "<leader>d", ":bw<CR>")
keymap.set("n", "<leader>v", ":vertical ball<CR>")

keymap.set("n", "<leader>b", ":bn<CR>")
-- keymap.set("n", "<leader>bn", ":bnext<CR>")
-- keymap.set("n", "<leader>bb", ":bprev<CR>")

keymap.set("n", "<leader>t", ":tabn<CR>", { noremap = true })
-- keymap.set("n", "<leader>tp", ":tabp<CR>", { noremap = true })
