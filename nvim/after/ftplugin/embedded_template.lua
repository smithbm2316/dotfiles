vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = {
    '*.ego',
    '*.ejs',
    '*.erb',
    '*.etlua',
  },
  group = vim.api.nvim_create_augroup(
    'EmbeddedTemplateFiletypeCmds',
    { clear = true }
  ),
  callback = function()
    -- insert ego template while already in insert mode (go shortcut)
    vim.keymap.set('i', '<c-i>t', function()
      -- get the current line and cursor position
      local line = vim.api.nvim_get_current_line()
      local cursor = vim.api.nvim_win_get_cursor(0)
      -- insert new template at the current cursor position in our line
      line = line:sub(1, cursor[2]) .. '<% %>' .. line:sub(cursor[2] + 1)
      -- prepare the cursor to be 2 characters more before we update the line contents
      cursor[2] = cursor[2] + 2
      -- update the line and cursor position
      vim.api.nvim_set_current_line(line)
      vim.api.nvim_win_set_cursor(0, cursor)
    end, { desc = 'Insert embedded template tag' })
  end,
})
