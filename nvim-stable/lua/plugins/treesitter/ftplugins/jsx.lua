vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = {
    '*.js',
    '*.ts',
    '*.jsx',
    '*.tsx',
  },
  group = vim.api.nvim_create_augroup('JSXFtCmds', { clear = true }),
  callback = function()
    vim.opt_local.textwidth = 0
    vim.opt_local.colorcolumn = '80'
    vim.opt_local.wrap = true
  end,
})
