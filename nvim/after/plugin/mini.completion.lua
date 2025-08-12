require('mini.completion').setup {
  mappings = {
    scroll_down = '<c-d>',
    scroll_up = '<c-u>',
  },
}

vim.keymap.set('i', '<c-k>', function()
  return vim.fn.pumvisible() and '<c-y>' or '<c-k>'
end, {
  expr = true,
  desc = 'confirm and select autocomplete menu item',
})
