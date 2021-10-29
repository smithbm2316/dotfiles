local ft_actions = {
  'TermOpen * startinsert',
  'FileType man,help,startuptime,qf,lspinfo nnoremap <buffer><silent> q :close<cr>',
}

for _, aucmd in ipairs(ft_actions) do
  vim.cmd('au! ' .. aucmd)
end
