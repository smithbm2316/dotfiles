local maps = {}
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local nosilent = { noremap = true }

-- unused opts atm, prime for remaps :D
map('n', 'gb', '<Nop>', opts)
map('v', 'gb', '<Nop>', opts)

map('n', 'gl', '<Nop>', opts)
map('v', 'gl', '<Nop>', opts)

map('n', 'gy', '<Nop>', opts)
map('v', 'gy', '<Nop>', opts)

map('n', 'gz', '<Nop>', opts)
map('v', 'gz', '<Nop>', opts)

map('n', '<c-_>', '<Nop>', opts)
map('v', '<c-_>', '<Nop>', opts)

-- packer sync baby
map('n', '<leader>ps', '<cmd>PackerSync<cr>', opts)

-- swap to alternate file
map('n', 'gp', '<c-^>', opts)
map('v', 'gp', '<c-^>', opts)

-- delete without yanking
map('n', '<leader>d', '"_d', opts)
map('v', '<leader>d', '"_d', opts)

-- replace currently selected text with default register without yanking it
map('v', 'p', '"_dP', opts)

-- Remap Y to yank to end of line instead of aliasing yy
map('n', 'Y', 'y$', opts)
map('v', 'Y', 'y$', opts)

-- run a g:command
map('n', 'go', ':', nosilent)
map('v', 'go', ':', nosilent)

-- repeat last macro
map('n', '<c-m>', '@@', opts)
map('v', '<c-m>', '@@', opts)

-- repeat last :command
map('n', '<c-s>', '@:', nosilent)
map('v', '<c-s>', '@:', nosilent)

-- remap q: to be easier to use, less work for your poor left pinky
map('n', 'gx', 'q:', nosilent)
map('v', 'gx', 'q:', nosilent)

-- Global Substitute: same as %s/
map('n', 'gs', ':%s/', opts)
map('v', 'gs', ':%s/', opts)

-- open quickfix list
map('n', '<c-q>', '<cmd>copen<cr>', opts)

-- make 'q' exit the quickfix window
vim.cmd [[au! FileType qf lua vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>cclose<cr>', { noremap = true })]]

-- quickfix list navigation yay
map('n', '<c-n>', '<cmd>cnext<cr>', opts)
map('n', '<c-p>', '<cmd>cprev<cr>', opts)

-- turn off search highlighting after finishing a search (nohlsearch)
map('n', '<leader>hl', '<cmd>noh<cr>', opts)

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
map('n', '<leader>oi', [[:tabnew +tcd\ ~/dotfiles/nvim ~/dotfiles/nvim/init.lua<cr>]], opts)
-- Source Here: Reload current buffer if it is a vim or lua file
map('n', '<leader>sh', '<cmd>lua require("my.maps").source_filetype()<cr>', opts)

-- turn terminal to normal mode with escape if it's not a lazygit terminal
maps.remap_term_escape = function()
  if vim.fn.bufname():match('lazygit') ~= 'lazygit' then
    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<c-\><c-n>]], opts)
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
map('n', '<leader>tn', '<cmd>lua require("my.maps").toggle_numbers()<cr>', opts)

return maps
