" if has_key(plugs, 'coc')
"   let g:coc_global_extensions = [
"   \  'coc-css', 
"   \  'coc-html', 
"   \  'coc-json', 
"   \  'coc-prettier', 
"   \  'coc-python', 
"   \  'coc-sh', 
"   \  'coc-styled-components', 
"   \  'coc-sql', 
"   \  'coc-tsserver', 
"   \  'coc-vimlsp',
"   \ ]
"   " use <tab> for trigger completion and navigate to the next complete item
"   function! s:check_back_space() abort
"     let col = col('.') - 1
"     return !col || getline('.')[col - 1]  =~ '\s'
"   endfunction
"   " inoremap <silent><expr> <Tab>
"   "       \ pumvisible() ? '\<C-n>' :
"   "       \ <SID>check_back_space() ? '\<Tab>' :
"   "       \ coc#refresh()
"   " Function to use for showing documentation in floating window
"   function! s:show_documentation()
"     if (index(['vim','help'], &filetype) >= 0)
"       execute 'h '.expand('<cword>')
"     else
"       call CocAction('doHover')
"     endif
"   endfunction
"   " Trigger completion menu in insert mode
"   " inoremap <silent><expr> <C-Space> coc#refresh()
"   " Coc Diagnostic: Move through diagnostic messages
"   nnoremap <leader>ml :CocList diagnostics<CR>
"   nnoremap <silent><leader>mp <Plug>(coc-diagnostic-prev)
"   nnoremap <silent><leader>mn <Plug>(coc-diagnostic-next)
"   " Coc Goto: Goto mappings
"   nnoremap <silent>gd <Plug>(coc-definition)
"   nnoremap <silent><leader>gt <Plug>(coc-type-definition)
"   nnoremap <silent><leader>gi <Plug>(coc-implementation)
"   nnoremap <silent><leader>gr <Plug>(coc-references)
"   " Coc Preview Definition: See documentation in floating preview window
"   nnoremap <silent>gh :call <SID>show_documentation()<CR>
"   " Coc Rename Symbol: rename word throughout file
"   nnoremap <silent> <leader>rs <Plug>(coc-rename)
"   " Coc Help Commands: Show all commands
"   nnoremap <silent> <leader>hc :CocList commands<CR>
" endif
