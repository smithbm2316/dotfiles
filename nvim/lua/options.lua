vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
-- vim.cmd [[filetype plugin off]]

vim.o.autoindent = true
vim.o.breakindent = true
vim.o.colorcolumn = '+1'
vim.o.cursorline = true
vim.o.errorbells = false
vim.o.expandtab = true
vim.o.exrc = true
vim.o.foldmethod = 'marker'
vim.o.hidden = true
vim.o.ignorecase = true
vim.o.inccommand = 'split'
vim.o.incsearch = true
vim.o.keywordprg = ':help'
vim.o.laststatus = 2
vim.o.lazyredraw = true
vim.o.linebreak = true
vim.o.mouse = 'n'
vim.o.nrformats = ''
vim.o.number = true
vim.o.path = '.,,'
vim.o.relativenumber = true
vim.o.shiftwidth = 2
vim.o.showmode = false
vim.o.showtabline = 0
vim.o.signcolumn = 'yes'
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.smarttab = true
vim.o.softtabstop = 2
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.termguicolors = true
vim.o.textwidth = 80
vim.o.updatetime = 2000
vim.o.wildmenu = true
vim.o.wildmode = 'full'
vim.o.wildoptions = 'pum'
vim.o.wrap = false
vim.opt.formatoptions:append 'jnrqlo'
vim.opt.formatoptions:remove '2ac' -- t
vim.opt.shortmess:append 'c'
vim.opt.wildignore = {
  '*.avi',
  '*.avif',
  '*.db',
  '*.env%..*',
  '*.env',
  '*.eot',
  '*.flv',
  '*.generated.d.ts',
  '*.heic',
  '*.ico',
  '*.jpeg',
  '*.jpg',
  '*.mkv',
  '*.mov',
  '*.mp3',
  '*.mp4',
  '*.otf',
  '*.png',
  '*.sqlite',
  '*.svg',
  '*.ttf',
  '*.wav',
  '*.webm',
  '*.webp',
  '*.woff',
  '*.woff2',
  '*.zip',
  '*/.git/*',
  '*/.next/.*',
  '*/.obsidian/*',
  '*/.yarn/.*',
  '*/__pycache__/*',
  '*/__snapshots__/*',
  '*/dist/.*',
  '*/generated-gql/*',
  '*/generated/*',
  '*/node_modules/*',
  '*/venv/*',
  '*/www/.*',
  '.DS_Store',
  '.obsidian.vimrc',
  'DS_Store',
  'deno.lock',
  'go.sum',
  'graphql.schema.json',
  'package-lock.json',
  'pnpm-lock.yaml',
  'yarn.lock',
}

-- highlight yank for a brief second for visual feedback
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { on_visual = false }
  end,
})
