local maps = {}
-- helper fn to get full rhs of mappings for this module
local mapfn = function(fn)
  return [[<cmd>lua require'my.maps'.]] .. fn .. [[()<cr>]]
end

-- TODO: add mapping for visual mode macro running
-- cc: https://www.hillelwayne.com/vim-macro-trickz/

-- unused opts atm, prime for remaps :D
nnoremap('Q', '<Nop>')
vnoremap('Q', '<Nop>')

nnoremap('gb', '<Nop>')
vnoremap('gb', '<Nop>')

nnoremap('gl', '<Nop>')
vnoremap('gl', '<Nop>')

nnoremap('gy', '<Nop>')
vnoremap('gy', '<Nop>')

nnoremap('gz', '<Nop>')
vnoremap('gz', '<Nop>')

nnoremap('<c-_>', '<Nop>')
vnoremap('<c-_>', '<Nop>')

-- unbind in normal mode { / } jumping
nnoremap('{', '<Nop>')
nnoremap('}', '<Nop>')

-- make gu toggle between upper and lower case instead of just upper
nnoremap('gu', 'g~')
vnoremap('gu', 'g~')

-- swap to alternate file
nnoremap('gp', '<c-^>')
vnoremap('gp', '<c-^>')

-- delete without yanking
nnoremap('<leader>d', '"_d')
vnoremap('<leader>d', '"_d')

-- replace currently selected text with default register without yanking it
vnoremap('p', '"_dP')

-- run a :command
nnoremap('go', ':', 'nosilent')
vnoremap('go', ':', 'nosilent')

-- repeat last macro
nnoremap('<c-m>', '@@')
vnoremap('<c-m>', '@@')

-- repeat last :command
nnoremap('<c-s>', '@:')
vnoremap('<c-s>', '@:')

-- remap q: to be easier to use, less work for your poor left pinky
nnoremap('gx', 'q:')
vnoremap('gx', 'q:')

-- Global Substitute: same as %s/
nnoremap('gs', ':%s/')
vnoremap('gs', ':%s/')

-- open quickfix list
nnoremap('<c-q>', '<cmd>copen<cr>')

-- make 'q' exit the quickfix window
vim.cmd [[au! FileType qf lua vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>cclose<cr>', { noremap = true })]]

-- quickfix list navigation yay
nnoremap('<c-n>', '<cmd>cnext<cr>')
nnoremap('<c-p>', '<cmd>cprev<cr>')

-- make more regular commands center screen too
nnoremap('n', 'nzz')
nnoremap('N', 'Nzz')
nnoremap('g;', 'g;zz')
nnoremap('gi', 'zzgi')

-- make c/C change command send text to black hole register, i didn't want
-- it anyways if I changed it probably
nnoremap('c', '"_c')
nnoremap('C', '"_C')

-- make <c-v> paste in insert and command-line mode too
icnoremap('<c-v>', '<c-r>+')
icnoremap('<c-v>', '<c-r>+')

-- make +/- increment/decrement numbers like <c-a>/<c-x>
-- and in visual/v-block mode the same like g<c-a>/g<c-x>, respectively
nnoremap('+', '<c-a>')
nnoremap('-', '<c-x>')
vnoremap('+', 'g<c-a>')
vnoremap('-', 'g<c-x>')

-- turn off search highlighting after finishing a search (nohlsearch)
nnoremap('<leader>hl', '<cmd>noh<cr>')

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
nnoremap('<leader>oi', [[:tabnew +tcd\ ~/dotfiles/nvim ~/dotfiles/nvim/init.lua<cr>]])
-- Source Here: Reload current buffer if it is a vim or lua file
nnoremap('<leader>sh', mapfn('source_filetype'))

-- Color picker wrapper
maps.convert_color_to = function()
  vim.cmd(string.format('ConvertColorTo %s', vim.fn.input('Convert to: ')))
end
nnoremap('<leader>cc',mapfn('convert_color_to'))

-- turn terminal to normal mode with escape if it's not a lazygit terminal
maps.remap_term_escape = function()
  if vim.fn.bufname():match('lazygit') ~= 'lazygit' then
    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<c-\><c-n>]], { noremap = true, silent = true })
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
nnoremap('<leader>tn', mapfn('toggle_numbers'))

-- toggle wrapping
maps.toggle_wrap = function()
  if vim.api.nvim_win_get_option(0, 'linebreak') then
    vim.api.nvim_win_set_option(0, 'linebreak', false)
    vim.api.nvim_win_set_option(0, 'wrap', false)
    print('wrapping off')
  else
    vim.api.nvim_win_set_option(0, 'linebreak', true)
    vim.api.nvim_win_set_option(0, 'wrap', true)
    print('wrapping on')
  end
end
nnoremap('<leader>tw', mapfn('toggle_wrap'))

maps.quit_session = function()
  vim.cmd('DeleteSession')
  vim.cmd('qall')
end
nnoremap('<leader>qa', mapfn('quit_session'))

-- change a split between horizontal and vertical
maps.change_split_direction = function()
  local a = vim.api
  local windows = a.nvim_tabpage_list_wins(0)

  if #windows ~= 2 then
    vim.notify('Only works for 2 splits', 'error')
    return
  end

  local ui = a.nvim_list_uis()[1]
  local win1_height = a.nvim_win_get_height(windows[1])
  local win2_height = a.nvim_win_get_height(windows[2])

  local cmd_mapping
  if ui.height < win1_height + win2_height then
    cmd_mapping = a.nvim_replace_termcodes('<c-w>K', true, false, true)
  else
    cmd_mapping = a.nvim_replace_termcodes('<c-w>L', true, false, true)
  end
  a.nvim_feedkeys(cmd_mapping, 'n', false)
end
nnoremap('<leader>wr', mapfn('change_split_direction'))

-- send expression under cursor as a query to Dash.app on macOS
maps.show_dash_docs = function()
  os.execute('open dash://' .. vim.fn.expand('<cexpr>'))
end
nnoremap('<leader>sd', mapfn('show_dash_docs'))


maps.luasnip_expand_or_jump = function()
  local luasnip = require('luasnip')
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  else
    vim.cmd('norm o')
  end
end
inoremap('<c-j>', mapfn('luasnip_expand_or_jump'))

-- switch between light/dark rose-pine theme
maps.toggle_rose_pine_variant = function()
  local colors = {
    moon = '#312f44',
    dawn = '#f2e9de',
  }
  require('rose-pine.functions').toggle_variant(vim.tbl_keys(colors))
  vim.cmd('hi IndentBlanklineIndent1 blend=nocombine guifg=' .. colors[vim.g.rose_pine_variant])
end
nnoremap('<leader>tt', mapfn('toggle_rose_pine_variant'))


return maps
