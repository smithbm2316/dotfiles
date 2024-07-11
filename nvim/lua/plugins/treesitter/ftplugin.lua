vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = {
    '*.html',
  },
  group = vim.api.nvim_create_augroup(
    'DjangoTemplateFiletypeCmds',
    { clear = true }
  ),
  callback = function()
    vim.bo.commentstring = '{# %s #}'
    insert_at_cursor_map('<c-i>t', '{%  %}', 'template', 'middle')
  end,
})

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
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
    vim.bo.commentstring = '<%# %s %>'
    insert_at_cursor_map('<c-i>t', '<%  %>', 'template', 'middle')
    insert_at_cursor_map('<c-i>.', '<%  %>', 'template', 'middle')
    insert_at_cursor_map('<c-i>=', '<%=  %>', 'template', 'middle')
  end,
})

vim.api.nvim_create_autocmd({ 'BufRead' }, {
  pattern = { '*.blade.php' },
  group = vim.api.nvim_create_augroup('BladePhpFtCmds', { clear = true }),
  callback = function()
    vim.bo.commentstring = '{{-- %s --}}'
    vim.cmd 'set ft=php'
  end,
})
