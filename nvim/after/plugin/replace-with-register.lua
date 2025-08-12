-- need this to override the new default neovim keybinding `gr` for lsp-related
-- actions when a new lsp server attaches to a buffer
-- issue that discovered this for me: https://github.com/LazyVim/LazyVim/discussions/1371
-- `:help gr-default` / `:help lsp-defaults-disable`
vim.keymap.del({ 'n', 'v' }, 'gra')
vim.keymap.del('n', 'grn')
vim.keymap.del('n', 'grr')
vim.keymap.del('n', 'gri')
vim.keymap.del('n', 'grt')
-- vim.keymap.del('n', 'gO')
