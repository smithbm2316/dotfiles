vim.api.nvim_create_augroup('PhpFiletypeCmds', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = { '*.blade.php', '*.php' },
  group = 'PhpFiletypeCmds',
  callback = function()
    vim.keymap.set('i', '<c-i>-', function()
      -- get the current line and cursor position
      local line = vim.api.nvim_get_current_line()
      local cursor = vim.api.nvim_win_get_cursor(0)
      -- insert '->' at the current cursor position in our line
      line = line:sub(1, cursor[2]) .. '->' .. line:sub(cursor[2] + 1)
      -- prepare the cursor to be 2 characters more before we update the line contents
      cursor[2] = cursor[2] + 2
      -- update the line and cursor position
      vim.api.nvim_set_current_line(line)
      vim.api.nvim_win_set_cursor(0, cursor)
    end, { desc = 'Insert "->" (php shortcut)' })

    vim.keymap.set('i', '<c-i>;', function()
      -- get the current line and cursor position
      local line = vim.api.nvim_get_current_line()
      local cursor = vim.api.nvim_win_get_cursor(0)
      -- insert '->' at the current cursor position in our line
      line = line:sub(1, cursor[2]) .. '::' .. line:sub(cursor[2] + 1)
      -- prepare the cursor to be 2 characters more before we update the line contents
      cursor[2] = cursor[2] + 2
      -- update the line and cursor position
      vim.api.nvim_set_current_line(line)
      vim.api.nvim_win_set_cursor(0, cursor)
    end, { desc = 'Insert "::" (php shortcut)' })

    vim.keymap.set('i', '<c-i>=', function()
      -- get the current line and cursor position
      local line = vim.api.nvim_get_current_line()
      local cursor = vim.api.nvim_win_get_cursor(0)
      -- insert '->' at the current cursor position in our line
      line = line:sub(1, cursor[2]) .. '=>' .. line:sub(cursor[2] + 1)
      -- prepare the cursor to be 2 characters more before we update the line contents
      cursor[2] = cursor[2] + 2
      -- update the line and cursor position
      vim.api.nvim_set_current_line(line)
      vim.api.nvim_win_set_cursor(0, cursor)
    end, { desc = 'Insert "=>" (php shortcut)' })
  end,
})
