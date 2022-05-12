-- delete all buffers
vim.api.nvim_create_user_command('Bgone', 'bufdo bd', {})

-- yank whole buffer
vim.api.nvim_create_user_command('YankBuf', 'normal ggVGy', {})
