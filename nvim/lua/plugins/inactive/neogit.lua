local has_neogit, neogit = pcall(require, 'neogit')

if has_neogit then
  require('neogit').setup {
    mappings = {
      status = {
        l = 'Toggle',
        o = 'Toggle',
        ['<c-k>'] = 'Toggle',
        gd = 'GoToFile',
      },
    },
  }

  nnoremap('gs', '<cmd>Neogit kind=vsplit<cr>')
end
