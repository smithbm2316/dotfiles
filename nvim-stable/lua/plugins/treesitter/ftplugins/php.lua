vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = { '*.blade.php', '*.php' },
  group = vim.api.nvim_create_augroup('PhpFtCmds', { clear = true }),
  callback = function()
    insert_at_cursor_map('<c-u>-', '->', 'php')
    insert_at_cursor_map('<c-u>.', '->', 'php')

    insert_at_cursor_map('<c-u>;', '::', 'php')
    insert_at_cursor_map('<c-u>c', '::class', 'php')

    insert_at_cursor_map('<c-u>=', '=>', 'php')

    insert_at_cursor_map('<c-u>v', '$', 'php')

    insert_at_cursor_map('<c-u>t', '$this->', 'php')
  end,
})
