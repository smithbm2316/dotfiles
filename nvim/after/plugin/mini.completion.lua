require('mini.completion').setup {
  -- delay = {
  --   completion = 250,
  --   info = 250,
  --   signature = 250,
  -- },
  mappings = {
    force_twostep = '<c-y>',
    force_fallback = nil,
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
