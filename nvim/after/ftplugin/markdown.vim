set linebreak
set wrap
set tw=0
set shiftwidth=2
set softtabstop=2
set tabstop=2

function! ScreenMovement(movement)
  if &wrap
    return "g" . a:movement
  else
    return a:movement
  endif
endfunction

augroup MarkdownMovement
  au!
  " remap regular commands
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
