vim.keymap.set({ 'n' }, '<leader><leader>cn', function()
  local has_notify, notify = pcall(require, 'notify')
  if has_notify then
    notify.dismiss { pending = true }
  else
    print 'nvim-notify not found for some reason'
  end
end, {
  silent = true,
})
