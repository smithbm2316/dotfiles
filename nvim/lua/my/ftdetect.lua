local ftdetect = {}

local ft_actions = {
  'BufRead,BufNewFile config,.ini set ft=dosini',
  'TermOpen * startinsert',
  'BufRead,BufNewFile .env* set ft=sh',
  'BufRead,BufNewFile *.conf set ft=conf',
  'BufRead,BufNewFile *.astro setfiletype astro',
  'BufRead,BufNewFile *.njk setfiletype nunjucks',
  'BufRead,BufNewFile *.fish setfiletype fish',
  'BufEnter *.fish set commentstring=#%s',
  'FileType man setlocal tw=0 wrapmargin=4 linebreak wrap',
  'FileType man,help,startuptime,qf,lspinfo nnoremap <buffer><silent> q :close<cr>'
}

for _, aucmd in ipairs(ft_actions) do
  vim.cmd('au! ' .. aucmd)
end

-- set markdown-specific mappings
ftdetect.markdown_mappings = function(movement)
  if vim.api.nvim_buf_get_option(0, 'wrap') then
    return 'g' .. movement
  else
    return movement
  end
end
vim.cmd 'au! FileType markdown setlocal wrap linebreak'
vim.cmd [[
function! ScreenMovement(movement)
  if &wrap
    return "g" . a:movement
  else
    return a:movement
  endif
endfunction
augroup MarkdownMovement
  au!
  au FileType markdown onoremap <silent> <expr> j ScreenMovement("j")
  au FileType markdown onoremap <silent> <expr> k ScreenMovement("k")
  au FileType markdown onoremap <silent> <expr> 0 ScreenMovement("0")
  au FileType markdown onoremap <silent> <expr> ^ ScreenMovement("^")
  au FileType markdown onoremap <silent> <expr> $ ScreenMovement("$")
  au FileType markdown nnoremap <silent> <expr> j ScreenMovement("j")
  au FileType markdown nnoremap <silent> <expr> k ScreenMovement("k")
  au FileType markdown nnoremap <silent> <expr> 0 ScreenMovement("0")
  au FileType markdown nnoremap <silent> <expr> ^ ScreenMovement("^")
  au FileType markdown nnoremap <silent> <expr> $ ScreenMovement("$")
augroup END
]]

return ftdetect
