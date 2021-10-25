nnoremap('<leader>dw', [[<cmd>lua require'dash'.search(false, vim.fn.expand('<cword>'))<cr>]])
nnoremap('<leader>ds', [[<cmd>lua require'dash'.search()<cr>]])
