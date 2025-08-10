return {
  'vim-scripts/ReplaceWithRegister',
  event = 'VeryLazy',
  config = function()
    -- need this to override the new default neovim keybinding `gr` for lsp-related
    -- actions when a new lsp server attaches to a buffer
    -- issue that discovered this for me: https://github.com/LazyVim/LazyVim/discussions/1371
    vim.keymap.del({ 'n', 'v' }, 'gra')
    vim.keymap.del({ 'n' }, 'gri')
    vim.keymap.del({ 'n' }, 'grn')
    -- vim.keymap.del({ 'n' }, 'g0')

    vim.keymap.set({ 'n', 'o' }, 'gr', '<Plug>ReplaceWithRegisterOperator', {
      desc = 'ReplaceWithRegisterOperator',
      remap = true,
    })
    vim.keymap.set({ 'v' }, 'gr', '<Plug>ReplaceWithRegisterVisual', {
      desc = 'ReplaceWithRegisterVisual',
      remap = true,
    })
    vim.keymap.set({ 'n', 'o' }, 'grr', '<Plug>ReplaceWithRegisterLine', {
      desc = 'ReplaceWithRegisterLine',
      remap = true,
    })
  end,
}
