" if has_key(plugs, 'prettier')

autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.html PrettierAsync
let g:prettier#config#single_quote = 'false'
let g:prettier#config#trailing_comma = 'es5'
let g:prettier#config#tab_width = '2'
let g:prettier#config#use_tabs = 'false'
nmap <Leader>py <Plug>(Prettier)

" endif
