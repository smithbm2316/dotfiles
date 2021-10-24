require('indent_blankline').setup({
  -- show_current_context = true,
  buftype_exclude = { 'terminal', 'man', 'nofile' },
  filetype_exclude = { 'help', 'man', 'startuptime', 'qf', 'lspinfo' },
  char_highlight_list = {
    'IndentBlanklineIndent1',
  },
})
vim.cmd('hi IndentBlanklineIndent1 guifg=#312f44 blend=nocombine')
