-- Aliases for Lua API functions
local o = vim.o
local wo = vim.wo
local bo = vim.bo

-- Enable syntax highlighting and filetype plugins
vim.cmd 'syntax enable'
vim.cmd 'filetype plugin indent on'

-- Buffer options
vim.api.nvim_exec([[
	set autoindent
	set expandtab
  set formatoptions-=2tac
  set formatoptions+=jnrql
	set shiftwidth=2
	set smartindent
	set softtabstop=2
	set tabstop=2
]], false)

-- Global options
o.errorbells = false
o.exrc = true
o.hidden = true
o.inccommand = 'split'
o.incsearch = true
o.ignorecase = true
o.keywordprg = ':help'
o.laststatus = 2
o.lazyredraw = true
o.mouse = 'n'
o.path = '.,,'
o.scrolloff = 3
o.showmode = false
o.shortmess = 'filnxtToOFc' -- f-F are defaults, c is the only addition here
o.showtabline = 1
o.smartcase = true
o.splitbelow = true
o.splitright = true
o.swapfile = true
o.wildmode = 'full'
o.wildignore = '*/node_modules/*,*/.git/*,DS_Store,*/venv/*,*/__pycache__/*,*.pyc'
o.wildmenu = true
o.wildoptions = 'pum'

-- Window options
wo.foldmethod = 'manual'
wo.relativenumber = true
wo.number = true
wo.signcolumn = 'yes' -- make sure this is on for gitsigns.nvim, otherwise the signcolumn changes size constantly
wo.wrap = false

-- Autocmds
vim.cmd 'autocmd BufWritePre * let &bex = "@" . strftime("%F.%H:%M")' -- for backups
vim.cmd 'autocmd TextYankPost * lua vim.highlight.on_yank { on_visual = false }' -- highlight yank for a brief second for visual feedback
vim.cmd 'autocmd! BufRead,BufNewFile *.conf,config,.ini setf dosini'

-- colorscheme global defaults
vim.o.background = 'dark'
vim.o.termguicolors = true
