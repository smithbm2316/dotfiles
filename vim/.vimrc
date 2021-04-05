" Set leader key
let mapleader="\<Space>"

syntax on
set autoindent
set backup
set backupcopy=yes
set backupdir=~/.config/nvim/backups//
set completeopt=menuone,preview,noselect
set expandtab
set hidden
set incsearch
set lazyredraw
set linebreak
set mouse=nc
set nocompatible
set noerrorbells
set noshowmode
set noswapfile
set number relativenumber
set path=.,,
set shiftwidth=2
set shortmess+=c
set showtabline=1
set signcolumn=yes
set smartcase
set smartindent
set softtabstop=2
set splitbelow
set splitright
set tabstop=2
set wildignore+=*/node_modules/*,*/.git/*,DS_Store,*/venv/*,*/__pycache__/*,*.pyc
set wildmenu
set wrap
set writebackup

syntax on
filetype on
filetype plugin on
filetype plugin indent on
autocmd BufWritePre * let &bex = '@' . strftime("%F.%H:%M")

" Look for any .local.vim files in a project and grab their configuration
silent! source .local.vim





"""""""""""""""""""""""""""""""""""""""""
"
" plugins (vim-plug)
"
"""""""""""""""""""""""""""""""""""""""""

packadd! matchit
call plug#begin('~/.config/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'alvan/vim-closetag', { 'for': ['html', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact'] }
  let g:closetag_filenames = '*.html, *.xml, *.jsx, *.js, *.ts, *.tsx'
Plug 'AndrewRadev/tagalong.vim', { 'for': ['html', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact'] }

Plug 'christoomey/vim-system-copy'
  let g:system_copy#copy_command = 'xclip -sel clipboard'
  let g:system_paste#paste_command = 'xclip -sel clipboard -o'
  let g:system_copy_silent = 1
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
  let g:go_highlight_extra_types = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_format_strings = 1
  let g:go_highlight_function_calls = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_types = 1
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
  nnoremap <leader>pt :NERDTreeToggle<CR>
  let g:NERDTreeShowHidden=1
  let g:NERDTreeHighlightFolders = 1
  let g:NERDTreeWinSize = 26
Plug 'romainl/vim-devdocs'
Plug 'RRethy/vim-hexokinase', { 'do': 'make' }
  let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba,hsl,hsla'
Plug 'ryanoasis/vim-devicons'
Plug 'SirVer/ultisnips'
  let g:UltiSnipsExpandTrigger="<Tab>"
  let g:UltiSnipsJumpForwardTrigger="<C-n>"
  let g:UltiSnipsJumpBackwardTrigger="<C-p>"
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
  autocmd FileType dosini setlocal commentstring=#\ %s
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'wincent/terminus'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'vim-scripts/ReplaceWithRegister'

" Syntax highlighting
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'scss'] }
Plug 'maxmellon/vim-jsx-pretty', { 'for': ['javascript', 'javascriptreact', 'typescript', 'typescriptreact'] }
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascriptreact', 'typescript', 'typescriptreact'] }
Plug 'styled-components/vim-styled-components', { 'for': ['javascript', 'javascriptreact', 'typescript', 'typescriptreact'] }
Plug 'vim-python/python-syntax', { 'for': 'python' }

call plug#end()

" Quickfix list remaps
nnoremap <leader>cn :cnext<CR>
nnoremap <leader>cp :cprevious<CR>
nnoremap <leader>cc :cclose<CR>

" Remap global search to gs, a useless command normally
nnoremap gs :%s/

" Swap marks jump points, ' now goes to exact spot, ` goes to BOL
nnoremap ' `
nnoremap ` '

" Remap Y to yank to end of line instead of aliasing yy
nnoremap Y y$

" Use built-in :find for searching files
nnoremap <C-Space> :find 

" Turn off search highlighting
nnoremap <leader>hl :nohlsearch<CR>
" Shortcut for editing vimrc
nnoremap <leader>orc e ~/.vimrc<CR>
nnoremap <leader>src :source ~/.vimrc<CR>
" Use <Esc> to go back to normal mode in a terminal
tnoremap <Esc> <C-\><C-n>
" Python language settings
au BufNewFile,BufRead *.Python
  \ set expandtab
  \ set autoindent
  \ set tabstop=4
  \ set softtabstop=4
  \ set shiftwidth=4
  \ set fileformat=unix

" Lightline settings
let g:lightline = {
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], 
  \             [ 'filename' ],
  \             [ 'gitbranch', 'gitgutter' ], ],
  \   'right': [ [ 'lineinfo', 'percent' ],
  \              [ 'cocstatus', 'filetype', 'readonly' ], ],
  \ },
  \ 'tabline': {
  \   'left': [ [ 'buffers' ] ],
  \   'right': [ ],
  \ },
  \ 'component_expand': {
  \   'buffers': 'lightline#bufferline#buffers',
  \ },
  \ 'component_type': {
  \   'buffers': 'tabsel',
  \ },
  \ 'component_function': {
  \   'cocstatus': 'coc#status',
  \   'gitbranch': 'LightLineGitBranch',
  \   'gitgutter': 'LightLineGitGutter',
  \ },
\ }
" GitHub issue detailing how to add extra Git info: https://github.com/itchyny/lightline.vim/issues/164
function! LightLineGitBranch()
  if exists("*FugitiveHead")
    let branch = FugitiveHead()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction
function! LightLineGitGutter()
  if exists("*FugitiveHead") && FugitiveHead() != ''
    let [ added, modified, removed ] = GitGutterGetHunkSummary()
    return printf('+%d ~%d -%d', added, modified, removed)
  else
    return ''
  endif
endfunction

set termguicolors
set laststatus=2

set background=dark
colorscheme laserwave
let g:lightline.colorscheme='laserwave'
