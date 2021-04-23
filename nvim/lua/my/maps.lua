-- Aliases for Lua API functions
local map = vim.api.nvim_set_keymap
local cmd = vim.cmd
-- Use the no recursive remapping for all remaps
options = { noremap = true }

-- delete without yanking
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
map('n', ';', ':', options)
map('v', ';', ':', options)
-- remap q: to be easier to use, less work for your poor left pinky
map('n', 'gl', 'q:', options)
map('v', 'gl', 'q:', options)
-- remap :h to be easier to use, less work for your poor left pinky
map('n', 'gh', ':help ', options)
map('v', 'gh', ':help ', options)

-- Search Globally: same as %s/
map('n', 'gs', ':%s/', options)
map('v', 'gs', ':%s/', options)
-- Search Line: same as s/
map('n', '<leader>sl', ':s/', options)
map('v', '<leader>sl', ':s/', options)

-- Turn off search highlighting after finishing a search (nohlsearch)
map('n', '<leader>hl', ':noh<cr>', options)

-- Fold Here: toggle a fold the cursor is currently in
map('n', '<leader>fh', 'za', options)
-- Fold Open: all in buffer
map('n', '<leader>fo', 'zo', options)
-- Fold Around {motion}
map('n', '<leader>fa', 'zfa', options)
-- Fold In {motion}
map('n', '<leader>fi', 'zfi', options)

function source_filetype()
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
map('n', '<leader>oi', ':tabnew +tcd\\ ~/.config/nvim ~/.config/nvim/init.lua<cr>', options)
-- Source Init.lua: Source changes from init.lua
map('n', '<leader>si', ':luafile ~/.config/nvim/init.lua<cr>', options)
-- Source Here: Reload current buffer if it is a vim or lua file
map('n', '<leader>sh', ':lua source_filetype()<cr>', options)

-- turn terminal to normal mode with escape
-- we have to use `\\` because `\` needs to be escaped when 
-- in a lua string for this mapping to work properly
map('t', '<esc>', '<c-\\><c-n>', options)

-- new tab
map('n', '<c-t>', ':tabnew<cr>', options)

-- toggle relativenumber on/off for all windows
function toggle_numbers(buf_win_or_tab)
  local command = buf_win_or_tab or 'windo set '
  if vim.api.nvim_win_get_option(0, 'relativenumber') then
    vim.cmd(command .. 'norelativenumber')
  else
    vim.cmd(command .. 'relativenumber')
  end
end
map('n', '<leader>tn', ':lua toggle_numbers()<cr>', options)
