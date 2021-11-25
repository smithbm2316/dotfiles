require('indent_blankline').setup {
  -- show_current_context = true,
  buftype_exclude = { 'terminal', 'man', 'nofile' },
  filetype_exclude = { 'help', 'man', 'startuptime', 'qf', 'lspinfo' },
  char_highlight_list = {
    'IndentBlanklineIndent1',
  },
}

local indent_hl = vim.g.rose_pine_variant == 'moon' and '#312f44' or '#f2e9de'
vim.cmd('hi IndentBlanklineIndent1 blend=nocombine guifg=' .. indent_hl)
nnoremap('<leader>hi', [[<cmd>lua require'indent_blankline.utils'.reset_highlights()<cr>]])
