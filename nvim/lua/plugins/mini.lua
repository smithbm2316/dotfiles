local has_minibuf, minibuf = pcall(require, 'mini.bufremove')

if has_minibuf then
  minibuf.setup {
    set_vim_settings = true,
  }
  vim.keymap.set({ 'n' }, '<leader>bd', minibuf.delete, { silent = true })
end
