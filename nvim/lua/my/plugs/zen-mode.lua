require('zen-mode').setup {
  window = {
    width = 104,
    backdrop = 0.95,
  },
}

vim.api.nvim_set_keymap('n', '<leader>z', [[<cmd>ZenMode<cr>]], { noremap = true })
