local ft_actions = {
  'BufRead,BufNewFile config,.ini set ft=dosini',
  'TermOpen * startinsert',
  'FileType man,help,startuptime,qf,lspinfo nnoremap <buffer><silent> q :close<cr>'
}

for _, aucmd in ipairs(ft_actions) do
  vim.cmd('au! ' .. aucmd)
end
