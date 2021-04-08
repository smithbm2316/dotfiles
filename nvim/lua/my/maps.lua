-- Aliases for Lua API functions
local map = vim.api.nvim_set_keymap
local cmd = vim.cmd
-- Use the no recursive remapping for all remaps
options = { noremap = true }

-- remap <c-w> to <c-f> in insert mode, i'm so sick of accidentally closing other programs
map('i', '<c-f>', '<c-w>', options)

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

-- Exit file remaps
map('n', '<leader>wf', ':w<cr>', options)
map('n', '<leader>wq', ':wq<cr>', options)
map('n', '<leader>qq', ':q<cr>', options)

-- Remap insert mode strokes for easier omnicomplete and line completion
-- map('i', '<c-f>', '<c-x><c-f>', options)
-- map('i', '<c-k>', '<c-x><c-o>', options)
map('i', '<c-l>', '<c-x><c-l>', options)

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
map('n', '<leader>sg', ':%s/', options)
map('n', 'gs', ':%s/', options)
map('v', '<leader>sg', ':%s/', options)
map('v', 'gs', ':%s/', options)
-- Search Line: same as s/
map('n', '<leader>sl', ':s/', options)
map('v', '<leader>sl', ':s/', options)
-- we have to use `\\` because `\` needs to be escaped when 
-- in a lua string for this mapping to work properly
-- Search Verymagic Line: search with very magic mode on line
map('n', '<leader>svl', ':s/\\v', options)
map('v', '<leader>svl', ':s/\\v', options)
-- Search Verymagic Globally: search with very magic mode globally
map('n', '<leader>svg', ':%s/\\v', options)
map('v', '<leader>svg', ':%s/\\v', options)

-- Turn off search highlighting after finishing a search (nohlsearch)
map('n', '<leader>hl', ':noh<cr>', options)

-- Goyo: Toggle Goyo on/off
map('n', '<leader>gy', ':Goyo<cr>', options)

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

-- abbreviations for easy directories
-- cmd = [[ iabbrev dconf '~/.config' ]]
-- cmd = [[ cabbrev dconf '~/.config' ]]
-- cmd = [[ iabbrev dnvim '~/.config/nvim' ]]
-- cmd = [[ cabbrev dnvim '~/.config/nvim' ]]
-- cmd = [[ iabbrev dplug '~/.config/nvim' ]]
-- cmd = [[ cabbrev dplug '~/.config/nvim' ]]

map('n', '<leader>ot', ':tabnew ~/code/tinkering.md<cr>', options)

-- zz, zt, and zb remaps
-- window middle
map('n', '<leader>wm', 'zz', options)
map('v', '<leader>wm', 'zz', options)
-- window top
map('n', '<leader>wt', 'zt', options)
map('v', '<leader>wt', 'zt', options)
-- window end
map('n', '<leader>we', 'zb', options)
map('v', '<leader>we', 'zb', options)

-- WINDOW COMMANDS
-- window rotate
map('n', '<leader>wr', '<c-w>r', options)
map('v', '<leader>wr', '<c-w>r', options)
-- window open full
map('n', '<leader>wo', '5<c-w>o', options)
map('v', '<leader>wo', '5<c-w>o', options)
-- make vertical split smaller
map('n', '<leader>wh', '5<c-w><', options)
map('v', '<leader>wh', '5<c-w><', options)
-- make vertical split bigger
map('n', '<leader>wl', '5<c-w>>', options)
map('v', '<leader>wl', '5<c-w>>', options)
-- make horizontal split smaller
map('n', '<leader>wj', '5<c-w>-', options)
map('v', '<leader>wj', '5<c-w>-', options)
-- make horizontal split bigger
map('n', '<leader>wk', '5<c-w>+', options)
map('v', '<leader>wk', '5<c-w>+', options)
-- make splits all equal
map('n', '<leader>we', '<c-w>=', options)
map('v', '<leader>we', '<c-w>=', options)

-- dfs curl function
function dfs(resource, token)
  vim.cmd('vnew')
  vim.cmd('set ft=json')
  vim.cmd('set linebreak')
  vim.cmd('set wrap')
  vim.cmd('read! curl -s -H "Accept: application/json" --oauth2-bearer ' .. token .. ' http:/localhost:8080/api' .. resource .. '| json_pp -json_opt pretty,canonical')
end

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
