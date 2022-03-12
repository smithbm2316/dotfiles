require('focus').setup {
  excluded_filetypes = { 'TelescopePrompt', 'help', 'harpoon' },
  signcolumn = false,
}

nnoremap('<leader>tf', [[<cmd>FocusToggle<cr>]])
