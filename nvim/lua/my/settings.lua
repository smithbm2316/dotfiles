-- Aliases for Lua API functions
local o = vim.o
local opt = vim.opt

-- Enable syntax highlighting and filetype plugins
vim.cmd 'syntax enable'
vim.cmd 'filetype plugin on'

-- Buffer options
o.autoindent = true
o.expandtab = true
opt.formatoptions:remove('2tac')
opt.formatoptions:append('jnrql')
o.shiftwidth=2
o.smartindent = true
o.softtabstop=2
o.tabstop=2

-- Global options
o.completeopt = 'menuone,noselect'
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
opt.shortmess:append('c')
o.showtabline = 1
o.smartcase = true
o.splitbelow = true
o.splitright = true
o.swapfile = true
o.wildmode = 'full'
o.wildignore = '*/node_modules/*,*/.git/*,DS_Store,*/venv/*,*/__pycache__/*,*.pyc'
o.wildmenu = true
o.wildoptions = 'pum'
o.updatetime = 2000

-- Window options
o.foldmethod = 'manual'
o.relativenumber = true
o.number = true
o.signcolumn = 'yes' -- make sure this is on for gitsigns.nvim, otherwise the signcolumn changes size constantly
o.wrap = false

-- Autocmds
-- vim.cmd 'autocmd! BufWritePre * let &bex = "@" . strftime("%F.%H:%M")' -- for backups
vim.cmd 'autocmd! TextYankPost * lua vim.highlight.on_yank { on_visual = false }' -- highlight yank for a brief second for visual feedback
vim.cmd 'autocmd! BufRead,BufNewFile *.conf,config,.ini setf dosini'
vim.cmd 'autocmd! TermOpen * startinsert'

-- colorscheme global defaults
o.background = 'dark'
o.termguicolors = true
