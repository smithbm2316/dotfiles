local ok, pasta = pcall(require, 'pasta')
if not ok then
  return
end

vim.keymap.set('n', 'p', require('pasta.mappings').p)
vim.keymap.set('n', 'P', require('pasta.mappings').P)

-- This is the default. You can omit `setup` call if you don't want to change this.
pasta.setup {
  converters = {},
  paste_mode = true,
  next_key = vim.api.nvim_replace_termcodes('<c-p>', true, true, true),
  prev_key = vim.api.nvim_replace_termcodes('<c-n>', true, true, true),
}
