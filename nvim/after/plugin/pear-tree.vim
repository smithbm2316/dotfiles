let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1
" pear-tree borks telescope's <CR> imap and other stuff
let g:pear_tree_ft_disabled = ['TelescopePrompt']
let g:pear_tree_pairs = {
    \   '(': {'closer': ')'},
    \   '[': {'closer': ']'},
    \   '{': {'closer': '}'},
    \ }

augroup html_jsx_pairs
  autocmd!
  autocmd FileType html,javascript,javascriptreact,typescript,typescriptreact,jsx,tsx let b:pear_tree_pairs = {
  \   '<*>': { 'closer': '</*>', 'not_like': '/$', 'until': '\W' },
  \ }
augroup END
