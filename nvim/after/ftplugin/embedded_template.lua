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
    insert_at_cursor_map('<c-i>t', '<% %>', 'template')
    insert_at_cursor_map('<c-i>.', '<% %>', 'template')
    insert_at_cursor_map('<c-i>=', '<%= %>', 'template')
  end,
})
