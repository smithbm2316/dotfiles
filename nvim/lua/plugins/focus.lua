require('focus').setup {
  excluded_filetypes = { 'TelescopePrompt', 'help', 'harpoon', 'DiffviewFiles' },
  excluded_buftypes = { 'nofile' },
  signcolumn = false,
}

nnoremap('<leader>tf', [[<cmd>FocusToggle<cr>]], 'Toggle Focus.nvim')
