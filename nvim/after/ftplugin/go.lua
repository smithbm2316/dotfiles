vim.api.nvim_create_augroup('GoFiletypeCmds', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = { '*.go', '*.templ' },
  group = 'GoFiletypeCmds',
  callback = function()
    -- insert ":=" while already in insert mode (go shortcut)
    vim.keymap.set('i', '<c-i>=', function()
      vim.api.nvim_feedkeys(':=', 'i', true)
    end, { desc = 'Insert ":=" (go shortcut)' })
  end,
})
