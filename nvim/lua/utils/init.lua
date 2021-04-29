local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

require('utils.log')
require('utils.luacheck')

-- Telescope Lint (run linting for Telescope development)
map('n', '<leader>tl', [[<cmd>lua require'utils.luacheck'.telescope()<cr>]], opts)
