" set a column at 120 so I know when luacheck will yell at me
set colorcolumn=120

" make sure for markdown files we don't wrap lines
augroup TelescopePluginDev
  au!
  au FileType markdown set nowrap nolinebreak
augroup END

" overwrite centerpad default command to center with the colorcolumn fully in sight
nnoremap <silent><leader>z <cmd>lua require'centerpad'.toggle{ leftpad = 22, rightpad = 22 }<cr>
