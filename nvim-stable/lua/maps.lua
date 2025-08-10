-- TODO: add mapping for visual mode macro running
-- cc: https://www.hillelwayne.com/vim-macro-trickz/

-- https://www.reddit.com/r/vim/comments/a8mp8z/comment/ecc0aw4
vim.keymap.set('n', 'j', [[v:count > 1 ? "m'" . v:count . 'j' : 'gj']], {
  expr = true,
})
vim.keymap.set('n', 'k', [[v:count > 1 ? "m'" . v:count . 'k' : 'gk']], {
  expr = true,
})
vim.keymap.set('n', 'gj', '<Down>')
vim.keymap.set('n', 'gk', '<Up>')

-- run a :command
vim.keymap.set({ 'n', 'v' }, 'go', ':', { desc = 'Command-line mode' })

-- Substitute Linewise
vim.keymap.set({ 'n', 'v' }, '<leader>sl', ':s/', { desc = 'Linewise search' })

-- Substitute Globally
vim.keymap.set(
  { 'n', 'v' },
  '<leader>sg',
  ':%s/',
  { desc = 'Global buffer search' }
)

-- make gu toggle between upper and lower case instead of just upper
vim.keymap.set({ 'n', 'v' }, 'gl', 'gu', { desc = 'Lowercase' })
vim.keymap.set({ 'n', 'v' }, 'gL', 'g~', { desc = 'Toggle case' })
vim.keymap.set({ 'n', 'v' }, 'gu', 'gU', { desc = 'Uppercase' })
vim.keymap.set({ 'n', 'v' }, 'gU', 'g~', { desc = 'Toggle case' })

-- swap to alternate file
vim.keymap.set({ 'n', 'v' }, 'ga', '<c-^>', { desc = 'Swap to alt file' })

-- replace currently selected text with default register without yanking it
vim.keymap.set('v', 'p', '"_dP', { desc = nil })

-- repeat last macro
vim.keymap.set({ 'n', 'v' }, '<c-m>', '@@', { desc = 'Repeat last macro' })

-- repeat last :command
vim.keymap.set({ 'n', 'v' }, 'gx', '@:', { desc = 'Repeat last command' })

-- remap q: to be easier to use, less work for your poor left pinky
vim.keymap.set({ 'n', 'v' }, '<c-q>', 'q:', { desc = 'Open cmdline window' })

vim.keymap.set('n', '<leader>qd', function()
  vim.ui.input(
    { prompt = 'Quickfix do: ', completion = 'command' },
    function(do_cmd)
      if do_cmd then
        vim.cmd('cfdo ' .. do_cmd)
      end
    end
  )
end, { desc = 'Exec cmd for all items in qf list' })

-- make more regular commands center screen too
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', 'g;', 'g;zz')
vim.keymap.set('n', 'gi', 'zzgi')
vim.keymap.set('n', '<c-d>', '<c-d>zz')
vim.keymap.set('n', '<c-u>', '<c-u>zz')
vim.keymap.set('n', '<c-f>', '<c-f>zz')
vim.keymap.set('n', '<c-b>', '<c-b>zz')
-- disable default bracket keymaps
vim.keymap.set('n', '{', '<nop>')
vim.keymap.set('n', '}', '<nop>')
vim.keymap.set('n', '(', '(zz')
vim.keymap.set('n', ')', ')zz')

-- make c/C change command send text to black hole register, i didn't want
-- it anyways if I changed it probably
vim.keymap.set('n', 'c', '"_c')
vim.keymap.set('n', 'C', '"_C')

-- make <c-v> paste in insert and command-line mode too
vim.keymap.set({ 'i', 'c' }, '<c-v>', '<c-r>+', { desc = 'Paste with <c-v>' })

-- turn off search highlighting after finishing a search (nohlsearch)
vim.keymap.set(
  'n',
  '<leader>hl',
  '<cmd>noh<cr>',
  { desc = 'Turn off search hl' }
)

-- take the only existing window and split it to the right
vim.keymap.set(
  'n',
  '<leader>wr',
  [[<cmd>vnew | wincmd r | wincmd l<cr>]],
  { desc = 'Split 1 window to right' }
)

-- swap windows and move cursor to other window
vim.keymap.set(
  'n',
  '<leader>wl',
  [[<cmd>wincmd r | wincmd l<cr>]],
  { desc = 'Swap windows and move cursor' }
)

-- folds management
vim.keymap.set('n', '<leader>fh', 'zA', { desc = 'Toggle current fold' })
vim.keymap.set('n', '<leader>fo', 'zR', { desc = 'Open all folds' })
vim.keymap.set('n', '<leader>fc', 'zM', { desc = 'Close all folds' })

-- Function mappings
-- Source Here: Reload current buffer if it is a vim or lua file
vim.keymap.set('n', '<leader>sh', function()
  local ft = vim.api.nvim_buf_get_option(0, 'filetype')
  if ft == 'vim' then
    vim.cmd 'source %'
    vim.notify('vim file reloaded!', vim.log.levels.INFO)
  elseif ft == 'lua' then
    vim.cmd 'luafile %'
    vim.notify('lua file reloaded!', vim.log.levels.INFO)
  else
    vim.notify('Not a lua or vim file', vim.log.levels.INFO)
  end
end, { desc = 'Source Here (reload current file)' })

-- toggle wrapping
vim.keymap.set('n', '<leader>tw', function()
  if vim.api.nvim_win_get_option(0, 'wrap') then
    vim.api.nvim_win_set_option(0, 'wrap', false)
    vim.notify('wrapping off', vim.log.levels.INFO)
  else
    vim.api.nvim_win_set_option(0, 'wrap', true)
    vim.notify('wrapping on', vim.log.levels.INFO)
  end
end, { desc = 'Toggle line wrapping' })

-- toggle conceallevel
vim.keymap.set('n', '<leader>tc', function()
  if vim.opt_local.conceallevel:get() ~= 0 then
    vim.opt_local.conceallevel = 0
  else
    vim.opt_local.conceallevel = 2
  end
end, { desc = 'Toggle conceallevel' })

-- change a split between horizontal and vertical
vim.keymap.set('n', '<leader>ws', function()
  local a = vim.api
  local windows = a.nvim_tabpage_list_wins(0)

  if #windows ~= 2 then
    vim.notify('Only works for 2 splits', vim.log.levels.ERROR)
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
end, { desc = 'Swap split between horizontal and vertical' })

-- use 'helpgrep' to grep through vim's help docs
vim.keymap.set('n', '<leader>hg', function()
  local pattern = vim.fn.input 'Pattern to search help docs for: '
  vim.cmd('helpgrep ' .. pattern)
end, { desc = 'Grep the help menu' })

vim.keymap.set('n', '<leader>mdn', function()
  local webdev = {
    'css',
    'html',
    'javascript',
    'javascriptreact',
    'svelte',
    'typescript',
    'typescriptreact',
    'vue',
  }
  local urls = {}
  for _, ft in ipairs(webdev) do
    urls[ft] = 'https://developer.mozilla.org/en-US/search?q=%s'
  end
  local current_ft = vim.api.nvim_buf_get_option(0, 'filetype')
  local input = vim.fn.input 'Enter docs query: '
  local query = urls[current_ft]:format(input)
  local cmd = vim.fn.has 'mac' == 0 and 'xdg-open ' or 'open '
  os.execute(cmd .. query)
end, { desc = 'Search MDN docs' })

vim.keymap.set('n', '<leader>ou', function()
  local uri = vim.fn.expand '<cWORD>'
  uri = vim.fn.matchstr(uri, [[https\?:\/\/[A-Za-z0-9-_\.#\/=\?%]\+]])
  if uri ~= '' then
    local cmd = vim.fn.has 'mac' == 0 and 'xdg-open ' or 'open '
    os.execute(cmd .. vim.fn.shellescape(uri, 1))
  end
end, { desc = 'Open url in browser' })

-- search dev docs
vim.keymap.set('n', '<leader>dd', function()
  local query = vim.fn.input 'Search DevDocs: '
  local encodedURL =
    string.format('open "https://devdocs.io/#q=%s"', query:gsub('%s', '%%20'))
  os.execute(encodedURL)
end, { desc = 'Search DevDocs' })

-- toggle relativenumber on/off for all windows
vim.keymap.set('n', '<leader>tn', function()
  if vim.api.nvim_win_get_option(0, 'relativenumber') then
    vim.cmd 'windo set norelativenumber'
  else
    vim.cmd 'windo set relativenumber'
  end
end, { desc = 'Toggle relative line numbers' })

vim.keymap.set('n', '<c-n>', '<cmd>cnext<cr>zz', {
  desc = 'Go to next quickfix item',
})
vim.keymap.set('n', '<c-p>', '<cmd>cprev<cr>zz', {
  desc = 'Go to previous quickfix item',
})
vim.keymap.set('n', '<leader>qf', '<cmd>copen<cr>', {
  desc = 'Open quickfix list',
})
vim.keymap.set('n', '<leader>qc', '<cmd>cclose<cr>', {
  desc = 'Exit quickfix list',
})

vim.keymap.set('n', '<leader>rq', [[<cmd>%s/"/'/g<cr>]], {
  desc = 'Replace [double] quotes [with single in whole file]',
})
