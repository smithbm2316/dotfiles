local luacheck = {}
local a = vim.api

luacheck.telescope = function()
  -- TODO: name the terminal buffer, and check to see if it already exists
  -- if it does, than run luacheck in there, instead of creating a new terminal
  -- tab and buffer
  local test = a.nvim_exec([[
    tabnew +terminal
    call feedkeys("luacheck --config ~/code/neovim/telescope.nvim/.luacheckrc ~/code/neovim/telescope.nvim/lua/telescope/*\<CR>")
  ]], true)

  print(test)
end

return luacheck
