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
opt.formatoptions:append 'jnrqlo'
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
o.showtabline = 0
o.smartcase = true
o.splitbelow = true
o.splitright = true
o.swapfile = false
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

-- disable builtin plugins i don't need
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
-- vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
--[[ vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1 ]]
