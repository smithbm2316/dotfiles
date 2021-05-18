local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
Utils = {}

-- wrapper for vim.inspect
Utils.print_table = function(item)
  print(vim.inspect(item))
  return item
end
map('n', '<leader>vi', [[:lua print( vim.inspect( ]], opts)

-- turn a table into a string for keymapping
Utils.tbl_to_str = function(tbl)
  local str_tbl = '{ '
  for k, v in pairs(tbl) do
    if type(v) == 'string' then
      v = string.format("'%s'", v)
    elseif type(v) == 'table' then
      v = Utils.tbl_to_str(v)
    end
    str_tbl = string.format([[%s %s = %s,]], str_tbl, k, v)
  end
  str_tbl = str_tbl:sub(1, -2) .. ' }'
  return str_tbl
end

require('utils.log')
require('utils.luacheck')

-- Telescope Lint (run linting for Telescope development)
map('n', '<leader>tl', [[<cmd>lua require'utils.luacheck'.telescope()<cr>]], opts)
