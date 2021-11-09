require('neogit').setup {
  mappings = {
    status = {
      ['<tab>'] = '',
      l = 'Toggle',
      o = 'Toggle',
      ['<c-k>'] = 'Toggle',
      gd = 'GoToFile',
    },
  },
}

nnoremap('gs', '<cmd>Neogit kind=vsplit<cr>')
