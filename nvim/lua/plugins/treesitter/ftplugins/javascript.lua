vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = {
    '*.js',
    '*.cjs',
    '*.mjs',
    '*.jsx',
    '*.ts',
    '*.tsx',
  },
  group = vim.api.nvim_create_augroup('JavascriptFtCmds', { clear = true }),
  callback = function()
    insert_at_cursor_map('<c-u>/', '/** @| */', 'jsdoc', true)
  end,
})
