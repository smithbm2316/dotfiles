if exists('g:loaded_vsnip')
  imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
  smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
  imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
  smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

  let g:vsnip_snippet_dir = expand('$HOME') . '/dotfiles/nvim/vsnip'

  let s:webdev = ['javascript', 'css', 'html']
  let g:vsnip_filetypes = {}
  let g:vsnip_filetypes.javascript = s:webdev
  let g:vsnip_filetypes.typescript = s:webdev
  let g:vsnip_filetypes.javascriptreact = s:webdev
  let g:vsnip_filetypes.typescriptreact = s:webdev
  let g:vsnip_filetypes.svelte = s:webdev
  let g:vsnip_filetypes.vue = s:webdev
endif
