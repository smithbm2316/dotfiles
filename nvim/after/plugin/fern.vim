" Fern plugins & temporary fix for neovim
" Plug 'antoinemadec/FixCursorHold.nvim'
let g:fern#renderer = "nerdfont"
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
augroup END
autocmd FileType fern set nonumber norelativenumber
