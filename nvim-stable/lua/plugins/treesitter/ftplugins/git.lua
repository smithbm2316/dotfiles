vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = {
    'git',
    'gitattributes',
    'gitcommit',
    'gitconfig',
    'gitignore',
    'gitrebase',
    'gitsendemail',
  },
  group = vim.api.nvim_create_augroup('GitFtCmds', { clear = true }),
  callback = function()
    vim.opt_local.textwidth = 72
  end,
})
