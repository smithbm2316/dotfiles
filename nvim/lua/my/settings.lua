-- Aliases for Lua API functions
local cmd = vim.cmd
local o = vim.o
local wo = vim.wo
local bo = vim.bo

-- Enable syntax highlighting and filetype plugins
cmd 'syntax enable'
cmd 'filetype plugin indent on'

-- Buffer options
-- Indentation settings
-- bo.autoindent = true
-- bo.expandtab = true
-- bo.formatoptions = '-=2tac'
-- bo.formatoptions = 'jnrql'
-- bo.shiftwidth = 2
-- bo.smartindent = true
-- bo.softtabstop = 2
-- bo.tabstop = 2
cmd [[
set autoindent
set expandtab
set formatoptions=jnrql
set shiftwidth=2
set smartindent
set softtabstop=2
set tabstop=2
]]

-- Global options
o.backup = false
-- o.backupcopy = 'yes'
-- o.backupdir = '~/.config/nvim/backups//'
-- o.completeopt = 'menu,menuone,noinsert'
o.errorbells = false
o.exrc = true
o.hidden = true
o.inccommand = 'split'
o.incsearch = true
o.ignorecase = true
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
-- o.writebackup = true

-- Window options
wo.foldmethod = 'manual'
wo.relativenumber = true
wo.number = true
wo.signcolumn = 'yes' -- make sure this is on for gitsigns.nvim, otherwise the signcolumn changes size constantly
wo.wrap = false

-- Autocmds
-- cmd 'autocmd BufWritePre * let &bex = "@" . strftime("%F.%H:%M")' -- for backups
cmd 'autocmd TextYankPost * lua vim.highlight.on_yank { on_visual = false }' -- highlight yank for a brief second for visual feedback

-- Colorscheme settings
o.termguicolors = true
o.laststatus = 2
o.background = 'dark'
