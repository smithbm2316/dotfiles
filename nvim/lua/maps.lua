local maps = {}
-- TODO: add mapping for visual mode macro running
-- cc: https://www.hillelwayne.com/vim-macro-trickz/

-- Basic mappings
--{{{
local nosilent = { silent = false }

--
-- https://www.reddit.com/r/vim/comments/a8mp8z/comment/ecc0aw4
nnoremap('j', [[v:count > 1 ? "m'" . v:count . 'j' : 'gj']], nil, { expr = true })
nnoremap('k', [[v:count > 1 ? "m'" . v:count . 'k' : 'gk']], nil, { expr = true })
nnoremap('gj', '<Down>')
nnoremap('gk', '<Up>')

-- run a :command
nnoremap('go', ':', 'Command-line mode', nosilent)
vnoremap('go', ':', 'Command-line mode', nosilent)

-- Substitute Linewise
nnoremap('<leader>sl', ':s/', 'Linewise search', nosilent)
vnoremap('<leader>sl', ':s/', 'Linewise search', nosilent)

-- Substitute Globally
nnoremap('<leader>sg', ':%s/', 'Global buffer search', nosilent)
vnoremap('<leader>sg', ':%s/', 'Global buffer search', nosilent)

-- unbind in normal mode { / } jumping
nnoremap('{', '<nop>')
nnoremap('}', '<nop>')

-- make gu toggle between upper and lower case instead of just upper
nnoremap('gu', 'g~', 'Toggle case', nosilent)
vnoremap('gu', 'g~', 'Toggle case', nosilent)

-- swap to alternate file
nnoremap('ga', '<c-^>', 'Swap to alt file', nosilent)
vnoremap('ga', '<c-^>', 'Swap to alt file', nosilent)

-- replace currently selected text with default register without yanking it
vnoremap('p', '"_dP', nil, nosilent)

-- repeat last macro
nnoremap('<c-m>', '@@', 'Repeat last macro', nosilent)
vnoremap('<c-m>', '@@', 'Repeat last macro', nosilent)

-- repeat last :command
nnoremap('gx', '@:', 'Repeat last command', nosilent)
vnoremap('gx', '@:', 'Repeat last command', nosilent)

-- remap q: to be easier to use, less work for your poor left pinky
nnoremap('<c-q>', 'q:', 'Open cmdline window', nosilent)
vnoremap('<c-q>', 'q:', 'Open cmdline window', nosilent)

-- quickfix list navigation yay
nnoremap('<leader>qn', '<cmd>cnext<cr>', 'Next item in qf list')
nnoremap('<leader>qp', '<cmd>cprev<cr>', 'Prev item in qf list')
nnoremap('<leader>qd', function()
  vim.ui.input({ prompt = 'Quickfix do: ', completion = 'command' }, function(do_cmd)
    if do_cmd then
      vim.cmd('cfdo ' .. do_cmd)
    end
  end)
end, 'Exec cmd for all items in qf list')

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
inoremap('<c-v>', '<c-r>+', 'Paste with <c-v>', nosilent)
cnoremap('<c-v>', '<c-r>+', 'Paste with <c-v>', nosilent)

-- turn off search highlighting after finishing a search (nohlsearch)
nnoremap('<leader>hl', '<cmd>noh<cr>', 'Turn off search hl')

-- take the only existing window and split it to the right
nnoremap('<leader>wr', [[<cmd>vnew | wincmd r | wincmd l<cr>]], 'Split 1 window to right')

-- swap windows and move cursor to other window
nnoremap('<leader>wl', [[<cmd>wincmd r | wincmd l<cr>]], 'Swap windows and move cursor')

-- <c-n>/<c-p> moves selected lines down/up in visual mode
--[[ nnoremap('<c-n>', '<cmd>m.+1<cr>==')
nnoremap('<c-p>', '<cmd>m.-2<cr>==')
vnoremap('<c-n>', '<cmd>m>+1<cr>gv=gv')
vnoremap('<c-p>', '<cmd>m<-2<cr>gv=gv') ]]

-- quit all forcefully
nnoremap('<leader>qf', '<cmd>qall!<cr>', 'Force quit all buffers')

-- folds management
nnoremap('<leader>fh', 'zA', 'Toggle current fold')
nnoremap('<leader>fo', 'zR', 'Open all folds')
nnoremap('<leader>fc', 'zM', 'Close all folds')

-- Add function + user command for reviewing a PR
vim.api.nvim_create_user_command('ReviewPR', 'lua vim.cmd("FocusDisable"); vim.cmd("DiffviewOpen main")', {})

-- open quickfix list
nnoremap('<leader>qo', '<cmd>copen<cr>', 'Open qflist')

-- enter in a new html tag above or below the current line
-- nnoremap('<leader>it', [[<cmd>call feedkeys("o<\<C-E>",', ''i')<cr>]])
-- nnoremap('<leader>iT', [[<cmd>call feedkeys("O<\<C-E>",', ''i')<cr>]])
---}}}

-- Function mappings
--{{{
-- Source Here: Reload current buffer if it is a vim or lua file
nnoremap('<leader>sh', function()
  local ft = vim.api.nvim_buf_get_option(0, 'filetype')
  if ft == 'vim' then
    vim.cmd 'source %'
    vim.notify('vim file reloaded!', 'info')
  elseif ft == 'lua' then
    vim.cmd 'luafile %'
    vim.notify('lua file reloaded!', 'info')
  else
    vim.notify('Not a lua or vim file', 'info')
  end
end, 'Source Here (reload current file)')

-- Color picker wrapper
nnoremap('<leader>cc', function()
  vim.cmd(string.format('ConvertColorTo %s', vim.fn.input 'Convert to: '))
end, 'Convert color')

-- toggle wrapping
nnoremap('<leader>tw', function()
  if vim.api.nvim_win_get_option(0, 'wrap') then
    vim.api.nvim_win_set_option(0, 'wrap', false)
    vim.notify('wrapping off', 'info')
  else
    vim.api.nvim_win_set_option(0, 'wrap', true)
    vim.notify('wrapping on', 'info')
  end
end, 'Toggle line wrapping')

nnoremap('<leader>qa', function()
  vim.cmd [[
    DeleteSession
    qall
  ]]
end, 'Quit session')

-- change a split between horizontal and vertical
nnoremap('<leader>ws', function()
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
end, 'Swap split between horizontal and vertical')

-- use 'helpgrep' to grep through vim's help docs
nnoremap('<leader>hg', function()
  local pattern = vim.fn.input 'Pattern to search help docs for: '
  vim.cmd('helpgrep ' .. pattern)
end, 'Grep the help menu')

nnoremap('<leader>mdn', function()
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
end, 'Search MDN docs')

nnoremap('<leader>ou', function()
  local uri = vim.fn.expand '<cWORD>'
  uri = vim.fn.matchstr(uri, [[https\?:\/\/[A-Za-z0-9-_\.#\/=\?%]\+]])
  if uri ~= '' then
    local cmd = vim.fn.has 'mac' == 0 and 'xdg-open ' or 'open '
    os.execute(cmd .. vim.fn.shellescape(uri, 1))
  end
end, 'Open url in browser')

-- search dev docs
nnoremap('<leader>dd', function()
  local query = vim.fn.input 'Search DevDocs: '
  local encodedURL = string.format('open "https://devdocs.io/#q=%s"', query:gsub('%s', '%%20'))
  os.execute(encodedURL)
end, 'Search DevDocs')
--}}}

-- toggle copilot on/off
nnoremap('<leader>tc', function()
  local cmd = 'Copilot '
  if vim.g.copilot_enabled == 1 or vim.g.copilot_enabled == nil then
    cmd = cmd .. 'disable'
  else
    cmd = cmd .. 'enable'
  end
  vim.cmd(cmd)
  vim.notify(cmd .. 'd', 'info')
end, 'Toggle Copilot')

-- toggle relativenumber on/off for all windows
nnoremap('<leader>tn', function()
  if vim.api.nvim_win_get_option(0, 'relativenumber') then
    vim.cmd 'windo set norelativenumber'
  else
    vim.cmd 'windo set relativenumber'
  end
end, 'Toggle relative line numbers')

-- view go documentation for a specified function
nnoremap('<leader>gd', function()
  vim.ui.input({ prompt = 'Keyword to search with `go doc`', completion = 'go' }, function(input)
    local Job = require 'plenary.job'
    local go_doc_lines = Job
      :new({
        command = 'go',
        args = { 'doc', input },
        cwd = '.',
        on_exit = function(j, return_val)
          return return_val and j:result() or nil
        end,
      })
      :sync()
    local lines = vim.o.lines
    local columns = vim.o.columns
    local bufnr = vim.api.nvim_create_buf(true, true)
    local height = vim.fn.float2nr(lines * 0.5)
    local width = vim.fn.float2nr(columns * 0.5)
    local horizontal = vim.fn.float2nr((columns - width) / 2)
    local vertical = vim.fn.float2nr((lines - height) / 2)
    local opts = {
      relative = 'editor',
      row = vertical,
      col = horizontal,
      width = width,
      height = height,
      style = 'minimal',
      border = 'shadow',
    }
    vim.api.nvim_buf_set_lines(bufnr, 1, -1, true, go_doc_lines)
    vim.api.nvim_buf_set_option(bufnr, 'ft', 'go')
    vim.api.nvim_buf_set_name(bufnr, 'go doc')
    nnoremap('q', function()
      vim.cmd 'q'
      vim.api.nvim_buf_delete(bufnr, { force = true })
    end, nil, { buffer = bufnr })
    vim.api.nvim_open_win(bufnr, true, opts)
  end)
end, 'go doc viewer')

-- mappings that require an external function
--{{{
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
nnoremap('<leader>tt', function()
  maps.toggle_rose_pine_variant()
end, 'Toggle color mode')

-- turn terminal to normal mode with escape if it's not a lazygit terminal
create_augroup('RemapTermEscapeUnlessLazygit', {
  {
    events = 'TermOpen',
    pattern = '*',
    callback = function()
      if vim.fn.expand '%:t' ~= 'lazygit' then
        tnoremap('<esc>', [[<c-\><c-n>]], 'Escape term', { buffer = 0 })
      end
    end,
  },
})

return maps
