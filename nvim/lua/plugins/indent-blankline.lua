local ok, indent_blankline = pcall(require, 'indent_blankline')
if not ok then
  return
end

indent_blankline.setup {
  buftype_exclude = { 'terminal', 'man', 'nofile' },
  filetype_exclude = { 'help', 'man', 'startuptime', 'qf', 'lspinfo' },
  show_current_context = true,
  show_current_context_start = false,
}
