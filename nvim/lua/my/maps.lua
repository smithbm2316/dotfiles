local maps = {}
-- Alias for Lua API functions
local map = vim.api.nvim_set_keymap
-- Use the no recursive remapping for all remaps
local options = { noremap = true }

-- swap to alternate file
map('n', 'gp', '<c-^>', options)
map('v', 'gp', '<c-^>', options)

-- delete without yanking
map('n', '<leader>d', '"_d', options)
map('v', '<leader>d', '"_d', options)

-- replace currently selected text with default register without yanking it
map('v', 'p', '"_dP', options)

-- Remap Y to yank to end of line instead of aliasing yy
map('n', 'Y', 'y$', options)
map('v', 'Y', 'y$', options)

-- remap : to be easier to use, less work for your poor left pinky
map('n', 'go', ':', options)
map('v', 'go', ':', options)

-- remap '<C-m>' to replace the ';' functionality for searching for previous
-- occurence with t/T/f/F
-- map('n', '<C-m>', ',', options)
-- map('v', '<C-m>', ',', options)

-- remap q: to be easier to use, less work for your poor left pinky
-- map('n', 'q;', 'q:', options)
-- map('v', 'q;', 'q:', options)

-- Global Substitute: same as %s/
map('n', 'gs', ':%s/', options)
map('v', 'gs', ':%s/', options)
-- Linewise Substitute: same as s/
map('n', 'gl', ':s/', options)
map('v', 'gl', ':s/', options)

-- Turn off search highlighting after finishing a search (nohlsearch)
map('n', '<leader>hl', ':noh<cr>', options)

maps.source_filetype = function()
  local buf = vim.api.nvim_get_current_buf() -- get reference to current buf
  local ft = vim.api.nvim_buf_get_option(buf, 'filetype') -- get filetype of buffer
  if ft == 'lua' then
    vim.cmd('luafile %')
    print('lua file reloaded!')
  elseif ft == 'vim' then
    vim.cmd('source %')
    print('vim file sourced!')
  else
    print('Not a lua or vim file')
  end
end

-- File Init: Open Neovim init.lua config in new tab
map('n', '<leader>oi', [[:tabnew +tcd\ ~/dotfiles/nvim ~/dotfiles/nvim/init.lua<cr>]], options)
-- Source Here: Reload current buffer if it is a vim or lua file
map('n', '<leader>sh', '<cmd>lua require("my.maps").source_filetype()<cr>', options)

-- turn terminal to normal mode with escape if it's not a lazygit terminal
maps.remap_term_escape = function()
  if vim.fn.bufname():match('lazygit') ~= 'lazygit' then
    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<c-\><c-n>]], options)
  end
end
vim.api.nvim_exec([[
  augroup RemapTermEscapeUnlessLazygit
    au!
    au TermOpen * lua require('my.maps').remap_term_escape()
  augroup END
]], false)

-- toggle relativenumber on/off for all windows
maps.toggle_numbers = function(buf_win_or_tab)
  local command = buf_win_or_tab or 'windo set '
  if vim.api.nvim_win_get_option(0, 'relativenumber') then
    vim.cmd(command .. 'norelativenumber')
  else
    vim.cmd(command .. 'relativenumber')
  end
end
map('n', '<leader>tn', '<cmd>lua require("my.maps").toggle_numbers()<cr>', options)

return maps
