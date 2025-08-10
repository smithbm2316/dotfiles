vim.api.nvim_create_autocmd({ 'BufRead' }, {
  pattern = { '*.blade.php' },
  group = vim.api.nvim_create_augroup('BladeFtCmds', { clear = true }),
  callback = function()
    vim.bo.commentstring = '{{-- %s --}}'
    vim.bo.filetype = 'php'
  end,
})
