" Set default browser to open in
let g:mkdp_browser = 'firefox'
" Print the preview url in the command line output
let g:mkdp_echo_preview_url = 1
" Start markdown preview server on port 5000
let g:mkdp_port = '5000'
" markdown preview toggle
nnoremap <leader>mp :MarkdownPreviewToggle<cr>
