-- vim.api.nvim_create_autocmd({ 'FileType' }, {
--   pattern = { 'tmpl' },
--   group = vim.api.nvim_create_augroup('GoTmplFtCmds', { clear = true }),
--   callback = function() end,
-- })

vim.filetype.add {
  extension = {
    tmpl = 'gotmpl',
  },
}
