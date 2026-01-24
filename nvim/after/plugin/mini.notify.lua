local columns = vim.api.nvim_get_option_value('columns', {})
local anchor = 'NW'
local col = 0
if columns <= 140 then
  anchor = 'NE'
  col = columns
end

require('mini.notify').setup {
  window = {
    ---@type vim.api.keyset.win_config
    config = {
      anchor = anchor,
      row = 0,
      col = col,
    },
  },
}

vim.notify = MiniNotify.make_notify()
