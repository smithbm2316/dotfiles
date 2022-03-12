-- lazygit options, cuz they don't work in packer config ???
vim.g.lazygit_floating_window_winblend = 1
vim.g.lazygit_floating_window_use_plenary = 1
vim.g.lazygit_floating_window_scaling_factor = 1
vim.g.lazygit_use_neovim_remote = 0

-- Aliases for Lua API functions
local o = vim.o
local opt = vim.opt

-- Enable syntax highlighting and filetype plugins
-- vim.cmd 'syntax enable'
-- vim.cmd 'filetype plugin on'

-- Buffer options
o.autoindent = true
o.expandtab = true
opt.formatoptions:remove '2tac'
opt.formatoptions:append 'jnrql'
o.shiftwidth = 2
o.smartindent = true
o.softtabstop = 2
o.tabstop = 2

-- Global options
o.cursorline = true
o.errorbells = false
o.exrc = true
o.hidden = true
o.ignorecase = true
o.inccommand = 'split'
o.incsearch = true
o.keywordprg = ':help'
o.laststatus = 2
o.lazyredraw = true
o.mouse = 'n'
o.nrformats = ''
o.path = '.,,'
o.showmode = false
o.showtabline = 1
o.smartcase = true
o.splitbelow = true
o.splitright = true
o.swapfile = true
o.updatetime = 2000
o.wildignore = '*/node_modules/*,*/.git/*,DS_Store,*/venv/*,*/__pycache__/*,*.pyc'
o.wildmenu = true
o.wildmode = 'full'
o.wildoptions = 'pum'
opt.shortmess:append 'c'

-- Window options
o.foldmethod = 'marker'
o.relativenumber = true
o.number = true
o.signcolumn = 'yes' -- make sure this is on for gitsigns.nvim, otherwise the signcolumn changes size constantly
o.wrap = false

-- Autocmds
vim.cmd 'au! TextYankPost * lua vim.highlight.on_yank { on_visual = false }' -- highlight yank for a brief second for visual feedback

-- colorscheme global defaults
o.background = 'dark'
o.termguicolors = true
