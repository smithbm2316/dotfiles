require('zen-mode').setup {
  window = {
    width = 104,
    backdrop = 0.95,
  },
}

nv.set_keymap('n', '<leader>z', [[<cmd>ZenMode<cr>]], { noremap = true })
