vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = { '*.go', '*.templ' },
  group = vim.api.nvim_create_augroup('GoFtCmds', { clear = true }),
  callback = function()
    insert_at_cursor_map('<c-i>=', ':=', 'go')
    insert_at_cursor_map('<c-i>;', ':=', 'go')
  end,
})
