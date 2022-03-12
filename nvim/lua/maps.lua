local maps = {}
-- helper fn to get full rhs of mappings for this module
local mapfn = function(fn)
  return [[<cmd>lua require'maps'.]] .. fn .. [[()<cr>]]
end

-- TODO: add mapping for visual mode macro running
-- cc: https://www.hillelwayne.com/vim-macro-trickz/

maps.source_filetype = function()
  local ft = vim.api.nvim_buf_get_option(0, 'filetype')
  if ft == 'lua' or ft == 'vim' then
    vim.cmd 'source %'
    vim.notify(ft .. ' file reloaded!', 'info')
  else
    vim.notify('Not a lua or vim file', 'info')
  end
end
-- Source Here: Reload current buffer if it is a vim or lua file
nnoremap('<leader>sh', mapfn 'source_filetype')

-- Color picker wrapper
maps.convert_color_to = function()
  vim.cmd(string.format('ConvertColorTo %s', vim.fn.input 'Convert to: '))
end
nnoremap('<leader>cc', mapfn 'convert_color_to')

-- turn terminal to normal mode with escape if it's not a lazygit terminal
maps.remap_term_escape = function()
  if vim.fn.bufname():match 'lazygit' ~= 'lazygit' then
    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<c-\><c-n>]], { noremap = true, silent = true })
  end
end
vim.api.nvim_exec(
  [[
  augroup RemapTermEscapeUnlessLazygit
    au!
    au TermOpen * lua require('maps').remap_term_escape()
  augroup END
]],
  false
)

-- toggle relativenumber on/off for all windows
maps.toggle_numbers = function(buf_win_or_tab)
  local command = buf_win_or_tab or 'windo set '
  if vim.api.nvim_win_get_option(0, 'relativenumber') then
    vim.cmd(command .. 'norelativenumber')
  else
    vim.cmd(command .. 'relativenumber')
  end
end
nnoremap('<leader>tn', mapfn 'toggle_numbers')

-- toggle wrapping
maps.toggle_wrap = function()
  if vim.api.nvim_win_get_option(0, 'linebreak') then
    vim.api.nvim_win_set_option(0, 'linebreak', false)
    vim.api.nvim_win_set_option(0, 'wrap', false)
    vim.notify('wrapping off', 'info')
  else
    vim.api.nvim_win_set_option(0, 'linebreak', true)
    vim.api.nvim_win_set_option(0, 'wrap', true)
    vim.notify('wrapping on', 'info')
  end
end
nnoremap('<leader>tw', mapfn 'toggle_wrap')

maps.quit_session = function()
  vim.cmd [[
    DeleteSession
    qall
  ]]
end
nnoremap('<leader>qa', mapfn 'quit_session')

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
nnoremap('<leader>ws', mapfn 'change_split_direction')

-- send expression under cursor as a query to Dash.app on macOS
maps.show_dash_docs = function()
  os.execute('open dash://' .. vim.fn.expand '<cexpr>')
end
nnoremap('<leader>sd', mapfn 'show_dash_docs')

-- switch between light/dark rose-pine theme
maps.toggle_rose_pine_variant = function(theme_variant)
  local colors = {
    dark = '#312f44',
    light = '#f2e9de',
  }
  local background = vim.api.nvim_get_option 'background'

  if theme_variant then
    background = theme_variant
  elseif background == 'light' then
    background = 'dark'
  else
    background = 'light'
  end

  vim.api.nvim_set_option('background', background)
  vim.cmd('hi IndentBlanklineIndent1 gui=nocombine guifg=' .. colors[background])
end
nnoremap('<leader>tt', mapfn 'toggle_rose_pine_variant')

-- use 'helpgrep' to grep through vim's help docs
maps.helpgrep = function()
  local pattern = vim.fn.input 'Pattern to search help docs for: '
  vim.cmd('helpgrep ' .. pattern)
end
nnoremap('<leader>hg', mapfn 'helpgrep')

maps.grep_docs = function()
  local webdev = { 'javascript', 'typescript', 'html', 'css', 'javascriptreact', 'typescriptreact' }
  local urls = {}
  for _, ft in ipairs(webdev) do
    urls[ft] = 'https://developer.mozilla.org/en-US/search?q=%s'
  end
  local current_ft = vim.api.nvim_buf_get_option(0, 'filetype')
  local input = vim.fn.input 'Enter docs query: '
  local query = urls[current_ft]:format(input)
  local cmd = vim.fn.has 'mac' == 0 and 'xdg-open ' or 'open '
  os.execute(cmd .. query)
end
nnoremap('<leader>gd', mapfn 'grep_docs')

maps.open_url_under_cursor = function()
  local uri = vim.fn.expand '<cWORD>'
  uri = vim.fn.matchstr(uri, [[https\?:\/\/[A-Za-z0-9-_\.#\/=\?%]\+]])
  if uri ~= '' then
    local cmd = vim.fn.has 'mac' == 0 and 'xdg-open ' or 'open '
    os.execute(cmd .. vim.fn.shellescape(uri, 1))
  end
end
nnoremap('<leader>ou', mapfn 'open_url_under_cursor')

maps.search_devdocs = function()
  local query = vim.fn.input 'Search DevDocs: '
  local encodedURL = string.format('open "https://devdocs.io/#q=%s"', query:gsub('%s', '%%20'))
  os.execute(encodedURL)
end
nnoremap('<leader>dd', mapfn 'search_devdocs')

maps.quit_force = function()
  local answer = vim.fn.input({
    prompt = 'Force quit neovim? ',
    cancelreturn = 'n',
  }):lower()
  if answer == '' then
    vim.cmd 'qa!'
  end
end
nnoremap('<leader>qf', mapfn 'quit_force')

return maps
