vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = {
    '*.ego',
    '*.ejs',
    '*.erb',
    '*.etlua',
  },
  group = vim.api.nvim_create_augroup(
    'EmbeddedTemplateFtCmds',
    { clear = true }
  ),
  callback = function()
    insert_at_cursor_map('<c-u>t', '<% | %>', 'template', true)
    insert_at_cursor_map('<c-u>.', '<% | %>', 'template', true)
    insert_at_cursor_map('<c-u>=', '<%= | %>', 'template', true)
  end,
})
