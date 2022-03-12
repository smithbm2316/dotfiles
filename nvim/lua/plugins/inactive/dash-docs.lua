local has_dash = pcall(require, 'dash')

if has_dash then
  nnoremap('<leader>dw', [[<cmd>lua require'dash'.search(false, vim.fn.expand('<cword>'))<cr>]])
  nnoremap('<leader>ds', [[<cmd>lua require'dash'.search()<cr>]])
end
