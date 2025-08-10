vim.keymap.set('n', '<leader>bd', function()
  require('mini.bufremove').delete()
end, { desc = 'Delete buffer' })
