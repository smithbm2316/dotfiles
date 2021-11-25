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
    print(ft .. ' file reloaded!')
  else
    print 'Not a lua or vim file'
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
    print 'wrapping off'
  else
    vim.api.nvim_win_set_option(0, 'linebreak', true)
    vim.api.nvim_win_set_option(0, 'wrap', true)
    print 'wrapping on'
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

maps.luasnip_expand_or_jump = function()
  local luasnip = require 'luasnip'
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  else
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<cr>', true, false, true), 'i')
  end
end
inoremap('<c-j>', mapfn 'luasnip_expand_or_jump')

-- switch between light/dark rose-pine theme
maps.toggle_rose_pine_variant = function()
  local colors = {
    moon = '#312f44',
    dawn = '#f2e9de',
  }
  require('rose-pine.functions').toggle_variant(vim.tbl_keys(colors))
  vim.cmd('hi IndentBlanklineIndent1 blend=nocombine guifg=' .. colors[vim.g.rose_pine_variant])

  -- reload cmp hlgroups
  local palette = require 'rose-pine.palette'
  local hl = require('rose-pine.util').highlight
  local hl_groups = {
    CmpItemAbbr = { fg = palette.subtle },
    CmpItemAbbrDeprecated = { fg = palette.highlight_inactive, style = 'strikethrough' },
    CmpItemAbbrMatch = { fg = palette.iris, style = 'bold' },
    CmpItemAbbrMatchFuzzy = { fg = palette.foam, style = 'bold' },
    CmpItemKind = { fg = palette.rose },
    CmpGhostText = { fg = palette.inactive, style = 'italic' },
    BiscuitColor = { fg = palette.subtle, style = 'italic' },
  }
  for hl_group, color_tbl in pairs(hl_groups) do
    hl(hl_group, color_tbl)
  end
end
nnoremap('<leader>tt', mapfn 'toggle_rose_pine_variant')

-- use 'helpgrep' to grep through vim's help docs
maps.helpgrep = function()
  local pattern = vim.fn.input 'Pattern to search help docs for: '
  vim.cmd('helpgrep ' .. pattern)
end
nnoremap('<leader>hg', mapfn 'helpgrep')

-- delete current buffer without losing your windows layout
-- https://stackoverflow.com/questions/4465095/how-to-delete-a-buffer-in-vim-without-losing-the-split-window
maps.bufdelete = function()
  local alt_buf = vim.fn.expand '#n:h'
  local alt_listed = vim.fn.buflisted(alt_buf) == 1 and true or false
  if alt_listed then
    vim.cmd 'b# | bd #'
  else
    -- vim.notify('alt buf not listed')
    vim.cmd 'bn | bd #'
  end
end
nnoremap('<leader>bd', mapfn 'bufdelete')

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

return maps
