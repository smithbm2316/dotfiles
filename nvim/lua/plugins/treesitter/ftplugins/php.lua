vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = { '*.blade.php', '*.php' },
  group = vim.api.nvim_create_augroup('PhpFtCmds', { clear = true }),
  callback = function()
    insert_at_cursor_map('<c-i>-', '->', 'php')
    insert_at_cursor_map('<c-i>.', '->', 'php')

    insert_at_cursor_map('<c-i>;', '::', 'php')
    insert_at_cursor_map('<c-i>c', '::class', 'php')

    insert_at_cursor_map('<c-i>=', '=>', 'php')

    insert_at_cursor_map('<c-i>v', '$', 'php')

    insert_at_cursor_map('<c-i>t', '$this->', 'php')
  end,
})
