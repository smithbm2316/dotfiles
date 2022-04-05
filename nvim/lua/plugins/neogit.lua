local ok, neogit = pcall(require, 'neogit')
if not ok then
  return
end

neogit.setup {
  kind = 'vsplit',
  mappings = {
    status = {
      h = 'Toggle',
      l = 'Toggle',
      gd = 'GoToFile',
      a = 'StageAll',
      ['<c-s>'] = 'StashPopup',
    },
  },
  integrations = {
    diffview = true,
  },
}

nnoremap('gs', function()
  neogit.open { kind = 'vsplit' }
end, 'Neogit in new vsplit')

nnoremap('gS', function()
  neogit.open { kind = 'tab' }
end, 'Neogit in new tab')
