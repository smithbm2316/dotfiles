-- Buffer-local options
vim.o.autoindent = true
vim.o.expandtab = true
vim.opt.formatoptions:remove '2ac' -- t
vim.opt.formatoptions:append 'jnrqlo'
vim.o.textwidth = 100
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.softtabstop = 2
vim.o.tabstop = 2

-- Global options
vim.o.background = 'dark'
vim.o.cursorline = true
vim.o.errorbells = false
vim.o.exrc = true
vim.o.hidden = true
vim.o.ignorecase = true
vim.o.inccommand = 'split'
vim.o.incsearch = true
vim.o.keywordprg = ':help'
vim.o.laststatus = 2
vim.o.lazyredraw = true
vim.o.mouse = 'n'
vim.o.nrformats = ''
vim.o.path = '.,,'
vim.o.showmode = false
vim.o.showtabline = 0
vim.o.smartcase = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.termguicolors = true
vim.o.updatetime = 2000
vim.o.wildignore = '*/node_modules/*,*/.git/*,DS_Store,*/venv/*,*/__pycache__/*,*.pyc'
vim.o.wildmenu = true
vim.o.wildmode = 'full'
vim.o.wildoptions = 'pum'
-- vim.o.virtualedit = 'all'
vim.opt.shortmess:append 'c'

-- Window-local options
vim.o.breakindent = true
vim.o.foldmethod = 'marker'
vim.o.linebreak = true
vim.o.relativenumber = true
vim.o.number = true
vim.o.signcolumn = 'yes' -- make sure this is on for gitsigns.nvim, otherwise the signcolumn changes size constantly
vim.o.wrap = true

-- Autocmds
-- highlight yank for a brief second for visual feedback
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { on_visual = false }
  end,
})

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
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
-- vim.g.loaded_matchit = 1
-- vim.g.loaded_matchparen = 1
