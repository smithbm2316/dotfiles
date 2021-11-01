require('focus').setup {
  excluded_filetypes = { 'TelescopePrompt', 'help', 'harpoon' },
  signcolumn = false,
}

nnoremap('<leader>ft', [[<cmd>FocusToggle<cr>]])
