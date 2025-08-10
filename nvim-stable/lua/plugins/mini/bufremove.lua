return {
  'echasnovski/mini.bufremove',
  version = '*',
  keys = {
    {
      '<leader>bd',
      function()
        require('mini.bufremove').delete()
      end,
      desc = 'Delete buffer',
    },
  },
  config = true,
}
