vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'man' },
  group = vim.api.nvim_create_augroup('ManFtCmds', { clear = true }),
  callback = function()
    -- vim.opt_local.linebreak = true
    -- vim.opt_local.textwidth = 80
    -- vim.opt_local.wrap = true
    -- vim.opt_local.wrapmargin = 4
    vim.keymap.set('n', '<leader>qa', '<cmd>qa!<cr>', {
      desc = '[q]uit [a]ll! (for vim.g.minimal)',
    })
  end,
})
