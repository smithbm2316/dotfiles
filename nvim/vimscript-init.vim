"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"  ███████╗███╗   ███╗██╗████████╗██╗  ██╗██████╗ ███╗   ███╗██████╗ ██████╗  ██╗ ██████╗ 
"  ██╔════╝████╗ ████║██║╚══██╔══╝██║  ██║██╔══██╗████╗ ████║╚════██╗╚════██╗███║██╔════╝ 
"  ███████╗██╔████╔██║██║   ██║   ███████║██████╔╝██╔████╔██║ █████╔╝ █████╔╝╚██║███████╗ 
"  ╚════██║██║╚██╔╝██║██║   ██║   ██╔══██║██╔══██╗██║╚██╔╝██║██╔═══╝  ╚═══██╗ ██║██╔═══██╗
"  ███████║██║ ╚═╝ ██║██║   ██║   ██║  ██║██████╔╝██║ ╚═╝ ██║███████╗██████╔╝ ██║╚██████╔╝
"  ╚══════╝╚═╝     ╚═╝╚═╝   ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚═╝     ╚═╝╚══════╝╚═════╝  ╚═╝ ╚═════╝ 
"
"  Ben Smith
"  github.com/smithbm2316
"  ben-smith.dev/
"  This is my neovim configuration!
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = "\<Space>"
" get Lua syntax highlighting inside of vim files
let g:vimsyn_embed = 'lPr'
" use tutorial command
" command! Scratch lua require('tools').makeScratch()

" Various vim settings
set autoindent
set backup
set backupcopy=yes
set backupdir=~/.config/nvim/backups//
set completeopt=menu,menuone,noinsert
set nocursorline
set expandtab
set exrc
set foldmethod=marker
set formatoptions-=2tac
set formatoptions=jnrql
set hidden
set ignorecase
set inccommand=split
set incsearch
set lazyredraw
set mouse=nc
set noerrorbells
set nojoinspaces
set noshowmode
set noswapfile
set nowrap
set number
set relativenumber
set path=.,,
set scrolloff=3
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
set wildoptions=pum
set writebackup

syntax on
filetype plugin indent on
autocmd BufWritePre * let &bex = '@' . strftime("%F.%H:%M")





" Require all lua plugin configs
" require('my.plugconfigs.nvim-autopairs')
lua require('my.plugconfigs.completion')
lua require('my.plugconfigs.nvim-lightbulb')
lua require('my.plugconfigs.nvim-lspconfig')
lua require('my.plugconfigs.nvim-tree')
lua require('my.plugconfigs.telescope')
lua require('my.plugconfigs.treesitter')





"""""""""""""""""""""""""""""""""""""""""
"
" plugins (vim-plug)
"
"""""""""""""""""""""""""""""""""""""""""
packadd! matchit
call plug#begin('~/.config/nvim/plugged')
" Appearance
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-slash'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'liuchengxu/vim-which-key'
Plug 'RRethy/vim-hexokinase', { 'do': 'make' }

" Editing
Plug 'alvan/vim-closetag', { 'for': ['html', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'svelte'] }
Plug 'AndrewRadev/tagalong.vim', { 'for': ['html', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact'] }
Plug 'cohama/lexima.vim'
Plug 'dkarter/bullets.vim', { 'for': ['markdown', 'text', 'latex'] }
Plug 'mbbill/undotree'
Plug 'SirVer/ultisnips'
" Plug 'tmsvg/pear-tree'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
" Plug 'windwp/nvim-autopairs'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Language Plugins
" Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

" Misc
Plug 'christoomey/vim-tmux-navigator'
Plug 'jez/vim-superman'
" Plug 'junegunn/fzf', {'do': { -> fzf#install() } } 
" Plug 'junegunn/fzf.vim'
Plug 'romainl/vim-devdocs'
Plug 'soywod/unfog.vim'
Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['javascript', 'typescript', 'json', 'html'] }
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" nvim 0.5+ plugins
if has('nvim-0.5')
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'neovim/nvim-lspconfig'
  Plug 'onsails/lspkind-nvim'
  Plug 'nvim-lua/completion-nvim'
  Plug 'nvim-treesitter/nvim-treesitter' , {'do': ':TSInstall css html javascript typescript tsx bash go c cpp jsdoc lua json python toml yaml haskell' }
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'ThePrimeagen/vim-be-good'
  Plug 'tjdevries/train.nvim'
  Plug 'kosayoda/nvim-lightbulb'
endif

" Syntax highlighting
" Plug 'cespare/vim-toml', { 'for': 'toml' }
" Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'scss'] }
" Plug 'yuezk/vim-js', { 'for': ['javascript', 'javascriptreact', 'typescript', 'typescriptreact'] }
" Plug 'HerringtonDarkholme/yats.vim', { 'for': ['javascript', 'javascriptreact', 'typescript', 'typescriptreact'] }
" Plug 'maxmellon/vim-jsx-pretty', { 'for': ['javascript', 'javascriptreact', 'typescript', 'typescriptreact'] }
" Plug 'neovimhaskell/haskell-vim', { 'for': ['haskell', 'lhaskell', 'hs', 'lhs' ] }

" Text objects
Plug 'christoomey/vim-system-copy'
Plug 'kana/vim-textobj-user'
Plug 'coachshea/vim-textobj-markdown'
Plug 'Julian/vim-textobj-variable-segment'
Plug 'vim-scripts/ReplaceWithRegister'

call plug#end()










"""""""""""""""""""""""""""""""""""""""""
"
" rebindings/keybindings/keymaps
"
"""""""""""""""""""""""""""""""""""""""""
" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" replace currently selected text with default register without yanking it
vnoremap p "_dP

" Remap Y to yank to end of line instead of aliasing yy
nnoremap Y y$
vnoremap Y y$

" Remap command mode to be easier to use, and enter to do the same thing as ;
" when searching for stuff
" nnoremap ; :
" vnoremap ; :
" nnoremap q; q:
" vnoremap q; q:
" nnoremap <CR> ;
" vnoremap <CR> ;
nnoremap gh :
vnoremap gh :
nnoremap go :
vnoremap go :

" Remap insert mode strokes for easier omnicomplete and line completion
" inoremap <c-f> <c-x><c-f>
" inoremap <c-k> <c-x><c-o>
inoremap <c-l> <c-x><c-l>

" remap : to be easier to use, less work for your poor left pinky
nnoremap go :
vnoremap go :

" Substitute Globally: same as %s/
nnoremap <leader>sg :%s/
nnoremap gs :%s/
" Substitute Line: same as s/
nnoremap <leader>sl :s/
" Substitute Verymagic Line: search with very magic mode on line
nnoremap <leader>svl :s/\v
" Substitute Verymagic Globally: search with very magic mode globally
nnoremap <leader>svg :%s/\v

" Turn off search highlighting after finishing a search (nohlsearch)
nnoremap <leader>hl :noh<CR>

" Goyo: Toggle Goyo on/off
" nnoremap <silent><leader>tz :Goyo<CR>
nnoremap <silent><leader>gy :Goyo<CR>

" Fold Here: toggle a fold the cursor is currently in
nnoremap <leader>fh za
" Fold Open: all in buffer
nnoremap <leader>fo zR
" Fold Up: all in buffer
nnoremap <leader>fu zM

" File Init: Open Neovim init.vim config in new buffer
nnoremap <leader>oi :tabnew $MYVIMRC<CR>
" Source Initvim: Source changes from init.vim
nnoremap <leader>si :so $MYVIMRC<CR>
" Source Here: Source current buffer (useful for editing plugin config files)
nnoremap <leader>sh :so %<CR>

" turn terminal to normal mode with escape
tnoremap <Esc> <c-\><c-n>

" vim-plug shortcuts
nnoremap <silent><leader>pi :PlugInstall<CR>
nnoremap <silent><leader>pc :PlugClean<CR>
nnoremap <silent><leader>pu :PlugUpdate<CR>

" new tab
nnoremap <c-t> :tabnew<CR>

" abbreviations for easy directories
iabbr dconf ~/.config
cabbr dconf ~/.config
iabbr dnvim ~/.config/nvim
cabbr dnvim ~/.config/nvim
iabbr dplug ~/.config/nvim
cabbr dplug ~/.config/nvim

" zz, zt, and zb remaps
" window middle
nnoremap <leader>wm zz
vnoremap <leader>wm zz
" window top
nnoremap <leader>wt zt
vnoremap <leader>wt zt
" window end
nnoremap <leader>we zb
vnoremap <leader>we zb




"""""""""""""""""""""""""""""""""""""""""
"
" language settings
"
"""""""""""""""""""""""""""""""""""""""""
" Highlight config, .conf, .ini files
" TODO: load syntax highlighing for dosini files instead of resetting filetype
augroup ConfigFiles
  autocmd!
  autocmd BufRead,BufNewFile *.conf,config,.ini setf dosini
augroup END

augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END











"""""""""""""""""""""""""""""""""""""""""
"
" lightline, colors, and theme settings
"
"""""""""""""""""""""""""""""""""""""""""

set termguicolors
set laststatus=2
set background=dark
colorscheme laserwave
