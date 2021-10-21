local luapad = {}

luapad.playground_tab = function()
  vim.cmd('tabnew')
  local tabwin = nv.tabpage_get_win(0)
  local scratch = nv.win_get_buf(tabwin)
  nv.buf_set_option(scratch, 'filetype', 'lua')

  local bufname = 'LuapadPlayground'
  if vim.g.luapad_playground_numbers then
    vim.g.luapad_playground_numbers = vim.g.luapad_playground_numbers + 1
    bufname = bufname .. tostring(vim.g.luapad_playground_numbers)
  else
    vim.g.luapad_playground_numbers = 1
    bufname = bufname .. '1'
  end
  nv.buf_set_name(scratch, bufname)
  require('luapad').attach()
end

-- REPL lua
nv.set_keymap('n', '<leader>rl', "<cmd>lua require('my.plugs.luapad').playground_tab()<cr>", { noremap = true, silent = true })

return luapad
