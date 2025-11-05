vim.keymap.set({ 'n', 'v' }, 'go', ':', { desc = 'Command-line mode' })

vim.keymap.set(
  'n',
  '<leader>sh',
  ':update<cr> :source %<cr> :echo "saved and reloaded!"<cr>',
  { desc = 'source here (save, execute, & reload current file)' }
)

vim.keymap.set('n', '<leader>gh', ':help ', { desc = 'Search the help menu' })

vim.keymap.set(
  'n',
  '<leader>hl',
  '<cmd>nohl<cr> ',
  { desc = 'Clear search highlighting' }
)

-- https://stackoverflow.com/a/4257175
vim.keymap.set(
  'n',
  '*',
  [[<cmd>keepjumps normal! mi*`i<cr>]],
  { desc = 'remap * to stay on current occurence' }
)

-- window maps
vim.keymap.set('n', '<leader>wr', function()
  vim.cmd 'vnew | wincmd r | wincmd l'
  vim.cmd('vertical resize ' .. tostring(math.ceil(vim.o.columns * 0.6)))
end, { desc = 'Split 1 window to right 60%' })
vim.keymap.set('n', '<leader>w=', function()
  vim.cmd('vertical resize ' .. tostring(math.ceil(vim.o.columns * 0.6)))
end, { desc = 'Set current window to 60% width' })
vim.keymap.set(
  'n',
  '<leader>wl',
  '<cmd>wincmd r | wincmd l<cr>',
  { desc = 'Swap windows and move cursor' }
)

vim.keymap.set('n', 'ga', '<c-^>', { desc = 'Go to alternate file' })

-- comment maps
vim.keymap.set({ 'n', 'x', 'o' }, 'cm', 'gc', { remap = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'cl', 'gc', { remap = true })

-- make gu toggle between upper and lower case instead of just upper
vim.keymap.set({ 'n', 'v' }, 'gl', 'gu', { desc = 'Lowercase' })
vim.keymap.set({ 'n', 'v' }, 'gL', 'g~', { desc = 'Toggle case' })
vim.keymap.set({ 'n', 'v' }, 'gu', 'gU', { desc = 'Uppercase' })
vim.keymap.set({ 'n', 'v' }, 'gU', 'g~', { desc = 'Toggle case' })

-- replace currently selected text with default register without yanking it
vim.keymap.set('v', 'p', '"_dP', { desc = nil })

-- make c/C change command send text to black hole register, i didn't want
-- it anyways if I changed it probably
vim.keymap.set('n', 'c', '"_c')
vim.keymap.set('n', 'C', '"_C')

-- make more regular commands center screen too
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', 'g;', 'g;zz')
vim.keymap.set('n', 'gi', 'zzgi')
vim.keymap.set('n', '<c-d>', '<c-d>zz')
vim.keymap.set('n', '<c-u>', '<c-u>zz')
vim.keymap.set('n', '<c-f>', '<c-f>zz')
vim.keymap.set('n', '<c-b>', '<c-b>zz')
vim.keymap.set('n', '(', '(zz')
vim.keymap.set('n', ')', ')zz')

-- toggle maps
vim.keymap.set('n', '<leader>tw', function()
  if vim.api.nvim_get_option_value('wrap', { win = 0 }) then
    vim.api.nvim_set_option_value('wrap', false, { win = 0 })
    vim.notify('wrapping off', vim.log.levels.INFO)
  else
    vim.api.nvim_set_option_value('wrap', true, { win = 0 })
    vim.notify('wrapping on', vim.log.levels.INFO)
  end
end, { desc = 'Toggle line wrapping' })

vim.keymap.set('n', '<leader>tc', function()
  ---@diagnostic disable-next-line: undefined-field
  if vim.opt_local.conceallevel:get() ~= 0 then
    vim.opt_local.conceallevel = 0
  else
    vim.opt_local.conceallevel = 2
  end
end, { desc = 'Toggle conceallevel' })

vim.keymap.set('n', '<leader>tn', function()
  if vim.api.nvim_get_option_value('relativenumber', { win = 0 }) then
    vim.api.nvim_set_option_value('relativenumber', false, { win = 0 })
  else
    vim.api.nvim_set_option_value('relativenumber', true, { win = 0 })
  end
end, { desc = 'Toggle relative line numbers' })

-- quickfix maps
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

vim.keymap.set(
  'n',
  '<leader>fm',
  [[/\C^\s\+-]],
  { desc = 'Find in manpage shortcut' }
)

vim.keymap.set(
  'n',
  '<leader>qr',
  '<cmd>restart<cr>',
  { desc = '[q]uit and [r]estart' }
)

vim.keymap.set({ 'n' }, '<leader>gl', function()
  local line_num = vim.api.nvim_win_get_cursor(0)[1]
  local bufname = vim.api.nvim_buf_get_name(0)
  local cwd = vim.fn.getcwd()

  local match_start, match_end = string.find(bufname, cwd)
  if match_start == nil or match_end == nil then
    return
  end
  local filename = string.sub(bufname, match_end + 1)

  ---@param cmd string[]
  ---@return string, number
  local get_git_branch_from_cmd = function(cmd)
    local branch_cmd = vim.system(cmd, { text = true }):wait()

    if branch_cmd.stdout == nil then
      return '', 0
    else
      return branch_cmd.stdout:gsub('origin/', ''):gsub('\n', '')
    end
  end

  local default_git_branch = get_git_branch_from_cmd {
    'git',
    'rev-parse',
    '--abbrev-ref',
    'origin/HEAD',
  }

  -- local current_git_branch = get_git_info 'git branch --show-current'
  local current_git_branch_ref =
    get_git_branch_from_cmd { 'git', 'symbolic-ref', '-q', 'HEAD' }

  local current_git_branch_with_remote = get_git_branch_from_cmd {
    'git',
    'for-each-ref',
    [[--format=%(upstream:short)]],
    current_git_branch_ref,
  }

  local branch = ''
  if current_git_branch_with_remote ~= '' then
    branch = current_git_branch_with_remote
  else
    branch = default_git_branch
  end

  -- TODO:
  -- * update this to support more than just Github as a git source forge to link to
  -- * update this to support pulling the Git repo URL from the .git/config file
  local git_url = string.format(
    [[https://github.com/thuma-co/astra/blob/%s%s#L%i]],
    branch,
    filename,
    line_num
  )

  -- copy the URL to clipboard
  vim.fn.setreg('+', git_url)

  -- open the URL in my browser
  vim.ui.open(git_url)
end, { desc = '[g]it repo [l]ink' })
