local ok, indent_blankline = pcall(require, 'ibl')
if not ok then
  return
end

indent_blankline.setup {
  exclude = {
    buftypes = { 'terminal', 'man', 'nofile' },
    filetypes = { 'help', 'man', 'startuptime', 'qf', 'lspinfo' },
  },
}
