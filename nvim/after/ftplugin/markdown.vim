set shiftwidth=2
set softtabstop=2
set tabstop=2

function! MarkdownScreenMovement(movement)
  if &wrap
    return "g" . a:movement
  else
    return a:movement
  endif
endfunction
augroup MarkdownMovement
  au!
  " remap regular commands
  au FileType markdown onoremap <silent> <expr> j MarkdownScreenMovement("j")
  au FileType markdown onoremap <silent> <expr> k MarkdownScreenMovement("k")
  au FileType markdown onoremap <silent> <expr> 0 MarkdownScreenMovement("0")
  au FileType markdown onoremap <silent> <expr> ^ MarkdownScreenMovement("^")
  au FileType markdown onoremap <silent> <expr> $ MarkdownScreenMovement("$")
  au FileType markdown nnoremap <silent> <expr> j MarkdownScreenMovement("j")
  au FileType markdown nnoremap <silent> <expr> k MarkdownScreenMovement("k")
  au FileType markdown nnoremap <silent> <expr> 0 MarkdownScreenMovement("0")
  au FileType markdown nnoremap <silent> <expr> ^ MarkdownScreenMovement("^")
  au FileType markdown nnoremap <silent> <expr> $ MarkdownScreenMovement("$")
augroup END
