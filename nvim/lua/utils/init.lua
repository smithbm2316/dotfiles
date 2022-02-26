local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
utils = {}

-- wrapper for vim.inspect
utils.print_table = function()
  local func = vim.fn.input { prompt = 'Run: ', completion = 'lua' }
  if not func then
    local result = vim.api.nvim_exec(string.format('lua %s', func), true)
    print(vim.inspect(result))
  end
end
map('n', '<leader>vi', [[:lua Utils.print_table()<cr>]], opts)

-- turn a table into a string for keymapping
utils.tbl_to_str = function(tbl)
  local str_tbl = '{ '
  for k, v in pairs(tbl) do
    if type(v) == 'string' then
      v = string.format("'%s'", v)
    elseif type(v) == 'table' then
      v = utils.tbl_to_str(v)
    end
    str_tbl = string.format([[%s %s = %s,]], str_tbl, k, v)
  end
  str_tbl = str_tbl:sub(1, -2) .. ' }'
  return str_tbl
end

utils.hl = function(group, color)
  local style = color.style and 'gui=' .. color.style or 'gui=NONE'
  local fg = color.fg and 'guifg=' .. color.fg or 'guifg=NONE'
  local bg = color.bg and 'guibg=' .. color.bg or 'guibg=NONE'
  local sp = color.sp and 'guisp=' .. color.sp or ''

  local hl = 'highlight ' .. group .. ' ' .. style .. ' ' .. fg .. ' ' .. bg .. ' ' .. sp

  vim.cmd(hl)
  if color.link then
    vim.cmd('highlight! link ' .. group .. ' ' .. color.link)
  end
end

require 'utils.log'
require 'utils.luacheck'

-- TODO: integrate luacheck linting into Neovim
-- Telescope Lint (run linting for Telescope development)
map('n', '<leader>tl', [[<cmd>lua require'utils.luacheck'.telescope()<cr>]], opts)
