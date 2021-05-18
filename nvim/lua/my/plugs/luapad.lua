local luapad = {}

luapad.playground_tab = function()
  vim.cmd('tabnew')
  local tabwin = vim.api.nvim_tabpage_get_win(0)
  local scratch = vim.api.nvim_win_get_buf(tabwin)
  vim.api.nvim_buf_set_option(scratch, 'filetype', 'lua')

  local bufname = 'LuapadPlayground'
  if vim.g.luapad_playground_numbers then
    vim.g.luapad_playground_numbers = vim.g.luapad_playground_numbers + 1
    bufname = bufname .. tostring(vim.g.luapad_playground_numbers)
  else
    vim.g.luapad_playground_numbers = 1
    bufname = bufname .. '1'
  end
  vim.api.nvim_buf_set_name(scratch, bufname)
  require('luapad').attach()
end

-- REPL lua
vim.api.nvim_set_keymap('n', '<leader>rl', "<cmd>lua require('my.plugs.luapad').playground_tab()<cr>", { noremap = true, silent = true })

return luapad
