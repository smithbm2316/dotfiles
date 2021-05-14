" make sure for markdown files we don't wrap lines
" for lua files auto-wrap at 120 chars, and add a colorcolumn
augroup TelescopePluginDev
  au!
  au FileType markdown setlocal nowrap nolinebreak
  au FileType lua setlocal tw=120 fo+=t cc=120
augroup END

" overwrite centerpad default command to center with the colorcolumn fully in sight
nnoremap <silent><leader>z <cmd>Centerpad 22<cr>
