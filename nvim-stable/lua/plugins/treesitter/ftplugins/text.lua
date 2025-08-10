vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'text' },
  group = vim.api.nvim_create_augroup('TextFtCmds', { clear = true }),
  callback = function()
    vim.bo.commentstring = '# %s'
  end,
})
