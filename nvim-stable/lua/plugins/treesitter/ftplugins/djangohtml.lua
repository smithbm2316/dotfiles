vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = {
    '*.html',
  },
  group = vim.api.nvim_create_augroup('DjangoTemplateFtCmds', { clear = true }),
  callback = function()
    insert_at_cursor_map('<c-u>t', '{% | %}', 'template', true)
  end,
})
