local has_minibuf, minibuf = pcall(require, 'mini.bufremove')

if has_minibuf then
  minibuf.setup {
    set_vim_settings = true,
  }
  nnoremap('<leader>bd', minibuf.delete)
end
