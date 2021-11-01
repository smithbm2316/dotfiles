""""""""""""""""""""""
" NOT silent mappings
""""""""""""""""""""""

" run a :command
nnoremap go :
vnoremap go :

" Search Forwards
nnoremap / /\v
vnoremap / /\v

" Search Backwards
nnoremap ? ?\v
vnoremap ? ?\v

" Substitute Linewise
nnoremap <leader>sl :s/\v
vnoremap <leader>sl :s/\v

" Substitute Globally
nnoremap <leader>sg :%s/\v
vnoremap <leader>sg :%s/\v





""""""""""""""""""""""
" silent mappings
""""""""""""""""""""""
" unbind in normal mode { / } jumping
nnoremap <silent> { <nop>
nnoremap <silent> } <nop>

" make gu toggle between upper and lower case instead of just upper
nnoremap <silent> gu g~
vnoremap <silent> gu g~

" swap to alternate file
nnoremap <silent> gp <nop>
vnoremap <silent> gp <nop>
nnoremap <silent> gl <nop>
vnoremap <silent> gl <nop>
nnoremap <silent> ga <c-^>
vnoremap <silent> ga <c-^>

" delete without yanking
" TODO: add operator mapping for this to work properly!
nnoremap <silent>s "_d
vnoremap <silent>s "_d

" replace currently selected text with default register without yanking it
vnoremap <silent> p "_dP

" repeat last macro
nnoremap <silent> <c-m> @@
vnoremap <silent> <c-m> @@

" repeat last :command
nnoremap <silent> gx @:
vnoremap <silent> gx @:

" remap q: to be easier to use, less work for your poor left pinky
nnoremap <silent> <c-q> q:
vnoremap <silent> <c-q> q:

" quickfix list navigation yay
nnoremap <silent> <c-n> <cmd>cnext<cr>
nnoremap <silent> <c-p> <cmd>cprev<cr>

" make more regular commands center screen too
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> g; g;zz
nnoremap <silent> gi zzgi

" make c/C change command send text to black hole register, i didn't want
" it anyways if I changed it probably
nnoremap <silent> c "_c
nnoremap <silent> C "_C

" make <c-v> paste in insert and command-line mode too
inoremap <silent> <c-v> <c-r>+
cnoremap <silent> <c-v> <c-r>+

" make +/- increment/decrement numbers like <c-a>/<c-x>
" and in visual/v-block mode the same like g<c-a>/g<c-x>, respectively
nnoremap <silent> + <c-a>
nnoremap <silent> - <c-x>
vnoremap <silent> + g<c-a>
vnoremap <silent> - g<c-x>

" turn off search highlighting after finishing a search (nohlsearch)
nnoremap <silent> <leader>hl <cmd>noh<cr>

" take the only existing window and split it to the right
nnoremap <silent> <leader>wr <cmd>vnew \| wincmd r \| wincmd l<cr>

" swap to left/right window and rotate the split
nnoremap <silent> <leader>wh <cmd>wincmd h \| wincmd r<cr>
nnoremap <silent> <leader>wl <cmd>wincmd l \| wincmd r<cr>

" treesitter textobject hinting
omap <silent> m :<c-u>lua require('tsht').nodes()<cr>
