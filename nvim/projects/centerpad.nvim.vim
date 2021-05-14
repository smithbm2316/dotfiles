" for the vim documentation, make sure we autowrap at 80 chars
augroup CenterpadConfig
  au!
  au FileType text setlocal tw=80 fo+=t cc=80
augroup END
