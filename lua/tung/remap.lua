-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local telescopebuiltin = require('telescope.builtin')
-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', telescopebuiltin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', telescopebuiltin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  telescopebuiltin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', telescopebuiltin.git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', telescopebuiltin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', telescopebuiltin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', telescopebuiltin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', telescopebuiltin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', telescopebuiltin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sk', telescopebuiltin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>ss', telescopebuiltin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sr', telescopebuiltin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', telescopebuiltin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })

-- Also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set('n', '<leader>s/', function()
  telescopebuiltin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = '[S]earch [/] in Open Files' })
-- Shortcut for searching your neovim configuration files
vim.keymap.set('n', '<leader>sn', function()
  telescopebuiltin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })

vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>", { desc = 'Open telescope file browser'})
-- vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = 'Save buffer to file'}) -- save file
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
-- vim.keymap.set('n', '<leader>o', '<cmd>AerialToggle!<CR>', { desc = 'Toggle outline/structure of file'})

vim.g.EasyMotion_do_mapping = 0
vim.keymap.set("n", "<leader>j", "<Plug>(easymotion-overwin-w)", { desc = 'Easymotion by word'}) 
