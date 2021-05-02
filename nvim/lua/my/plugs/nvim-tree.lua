-- Aliases for Lua API functions
local map = vim.api.nvim_set_keymap
map('n', '<leader>pt', '<cmd>NvimTreeToggle<cr>', { noremap = true })

vim.g.nvim_tree_side = 'left'
vim.g.nvim_tree_width = 25
vim.g.nvim_tree_ignore = { '.git', 'node_modules', 'venv' }
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_auto_open = 0
vim.g.nvim_tree_auto_close = 1
vim.cmd [[ let g:nvim_tree_icons = { 'default': '' } ]]
