" make sure for markdown files we don't wrap lines
" for lua files auto-wrap at 120 chars, and add a colorcolumn
augroup TelescopePluginDev
  au!
  au FileType markdown setlocal nowrap nolinebreak
  au FileType lua setlocal tw=120 fo+=t cc=120
augroup END

nnoremap <silent><leader>z <cmd>lua require("zen-mode").toggle({ window = { width = 126 } })<cr>
