local ok, focus = pcall(require, 'focus')
if not ok then
  return
end

focus.setup {
  excluded_filetypes = { 'TelescopePrompt', 'help', 'harpoon', 'DiffviewFiles' },
  excluded_buftypes = { 'nofile' },
  signcolumn = false,
}

nnoremap('<leader>tF', function()
  focus.focus_toggle()
end, 'Toggle Focus.nvim')
