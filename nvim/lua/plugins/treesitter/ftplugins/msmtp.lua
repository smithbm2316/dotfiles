vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'msmtp' },
  group = vim.api.nvim_create_augroup('MsmtpFtCmds', { clear = true }),
  callback = function()
    vim.bo.commentstring = '# %s'
  end,
})
