local ok, indent_blankline = pcall(require, 'indent_blankline')
if not ok then
  return
end

indent_blankline.setup {
  -- show_current_context = true,
  buftype_exclude = { 'terminal', 'man', 'nofile' },
  filetype_exclude = { 'help', 'man', 'startuptime', 'qf', 'lspinfo' },
  char_highlight_list = {
    'IndentBlanklineIndent1',
  },
}
