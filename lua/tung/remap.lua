-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })


vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>", { desc = 'Open telescope file browser'})
vim.keymap.set("n", "<leader>fe", ":Ex<CR>", { desc = 'Open netrw file browser'})
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = 'Save buffer to file'}) -- save file
vim.keymap.set("n", "<leader>m", ":conf q<CR>", { desc = 'Close buffer with confirmation'}) -- close buffer

-- window movement
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = 'Move to left window'})
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = 'Move to right window'})
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = 'Move to below window'})
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = 'Move to upper window'})

-- moving between line
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'Move forward 1/2 screen and center'})
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'Move back 1/2 screen and center'})
vim.keymap.set("n", "<C-f>", "<C-f>zz", { desc = 'Move forward 1/2 screen and center'})
vim.keymap.set("n", "<C-b>", "<C-b>zz", { desc = 'Move back 1 screen and center'})
