vim.api.nvim_create_autocmd({ 'BufRead' }, {
  pattern = { '*.blade.php' },
  group = vim.api.nvim_create_augroup('BladePhpFtCmds', { clear = true }),
  callback = function()
    vim.bo.commentstring = '{{--%s--}}'
    vim.cmd 'set ft=php'
  end,
})
