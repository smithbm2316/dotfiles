vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'swayconfig' },
  group = vim.api.nvim_create_augroup('SwayConfigFtCmds', { clear = true }),
  callback = function()
    -- vim.cmd [[setlocal commentstring=#\ %s]]
    vim.bo.commentstring = '# %s'
  end,
})
