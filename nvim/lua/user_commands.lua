-- delete all buffers
vim.api.nvim_add_user_command('Bgone', 'bufdo bd', {})

-- yank whole buffer
vim.api.nvim_add_user_command('YankBuf', 'normal ggVGy', {})
