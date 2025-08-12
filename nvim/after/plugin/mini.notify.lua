require('mini.notify').setup {
  window = {
    ---@type vim.api.keyset.win_config
    config = {
      anchor = 'NW',
      row = 0,
      col = 0,
    },
  },
}

vim.notify = MiniNotify.make_notify()
