require('utils.log')
require('utils.center_buf')
vim.api.nvim_set_keymap('n', '<leader>z', ':lua require"utils.center_buf".toggle()<cr>', { noremap = true, silent = true })
