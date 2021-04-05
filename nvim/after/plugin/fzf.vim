" if has_key(plugs, 'fzf')
" " Open all fzf instances in 12-line-tall new horizontal split
" let g:fzf_layout = {'window': '12new'}

" " From Primeagen's vimrc: https://youtu.be/-X6rEdZolTA
" let g:fzf_layout = {'window': { 'width': 0.7, 'height': 0.7 } }
" let $FZF_DEFAULT_OPTS='--reverse'

" " Project Find File: FZF find file in project
" nnoremap <silent><leader>pf :Files<CR>
" " Find File: search for files in specified directory
" nnoremap <silent><leader>ff :Files 
" " Find Dotfile: look in dotfiles folder
" nnoremap <silent><leader>fd :Files ~/.config<CR>
" " Search in git files
" nnoremap <leader>gf :GFiles<CR>
" " Buffer Switch Buffer: Switch to another buffer
" nnoremap <leader>bl :Buffers<CR>
" " Help Mappings: Open mappings listing in FZF
" nnoremap <leader>hm :Maps<CR>
" " Git Commits Log: Open commits for current file in FZF
" nnoremap <leader>gc :Commits<CR>

" " Set up a new :RG command that ignores node_modules folder by default
" function! RipgrepFzf(query, fullscreen)
"   let command_fmt = 'rg --column --line-number --no-heading --color=always -g "!node_modules/" --smart-case -- %s || true'
"   let initial_command = printf(command_fmt, shellescape(a:query))
"   let reload_command = printf(command_fmt, '{q}')
"   let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
"   call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
" endfunction

" command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" " Ripgrep: FZF use rg
" nnoremap <leader>ps :RG<CR>
" endif
