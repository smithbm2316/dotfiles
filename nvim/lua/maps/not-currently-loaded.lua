-- TODO: add mapping for visual mode macro running
-- cc: https://www.hillelwayne.com/vim-macro-trickz/

-- https://www.reddit.com/r/vim/comments/a8mp8z/comment/ecc0aw4
vim.keymap.set('n', 'j', [[v:count > 1 ? "m'" . v:count . 'j' : 'gj']], {
  expr = true,
})
vim.keymap.set('n', 'k', [[v:count > 1 ? "m'" . v:count . 'k' : 'gk']], {
  expr = true,
})
vim.keymap.set('n', 'gj', '<Down>')
vim.keymap.set('n', 'gk', '<Up>')

-- disable default bracket keymaps
vim.keymap.set('n', '{', '<nop>')
vim.keymap.set('n', '}', '<nop>')
