""""""""""""""""""""""
" NOT silent mappings
""""""""""""""""""""""

" run a :command
nnoremap go :
vnoremap go :

" Substitute Linewise
nnoremap <leader>sl :s/
vnoremap <leader>sl :s/

" Substitute Globally
nnoremap <leader>sg :%s/
vnoremap <leader>sg :%s/

" Substitute Repeat
nnoremap <leader>sr :@
vnoremap <leader>sr :@




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
nnoremap <silent> <leader>qn <cmd>cnext<cr>
nnoremap <silent> <leader>qp <cmd>cprev<cr>

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

" swap windows and move cursor to other window
nnoremap <silent> <leader>wl <cmd>wincmd r \| wincmd l<cr>

" swap to left/right window and rotate the split
" nnoremap <silent> <leader>wh <cmd>wincmd h \| wincmd r<cr>
" nnoremap <silent> <leader>wl <cmd>wincmd l \| wincmd r<cr>

" treesitter textobject hinting
omap <silent> m :<c-u>lua require('tsht').nodes()<cr>

" <c-n>/<c-p> moves selected lines down/up in visual mode
nnoremap <silent> <c-n> :m .+1<CR>==
nnoremap <silent> <c-p> :m .-2<CR>==
vnoremap <silent> <c-n> :m '>+1<CR>gv=gv
vnoremap <silent> <c-p> :m '<-2<CR>gv=gv

" Add function + user command for reviewing a PR
function ReviewPR()
  FocusDisable
  " add command to pull main branch instead of just 'main'
  DiffviewOpen main
endfunction
command ReviewPR call ReviewPR()

" open quickfix list
nnoremap <silent> <leader>qo <cmd>copen<cr>

" open and close folds
nnoremap <silent> <leader>fh zA
nnoremap <silent> <leader>fo zR
nnoremap <silent> <leader>fc zM

" enter in a new html tag above or below the current line
nnoremap <silent> <leader>to <cmd>call feedkeys("o<\<C-E>", 'i')<cr>
nnoremap <silent> <leader>tO <cmd>call feedkeys("O<\<C-E>", 'i')<cr>
