-- runs :noh whenever the mouse cursor is moved 
return {
  'junegunn/vim-slash',
  event = 'VeryLazy',
  config = function()
    vim.keymap.set(
      'n',
      '<plug>(slash-after)',
      'zz',
      { desc = 'Center screen after :nohl' }
    )

    vim.keymap.set('n', '<esc>', '<cmd>nohl<cr>', {
      desc = 'Clear hlsearch on <esc>',
    })
  end,
}
