-- Buffer-local options
vim.o.autoindent = true
vim.o.expandtab = true
vim.opt.formatoptions:remove '2ac' -- t
vim.opt.formatoptions:append 'jnrqlo'
vim.o.colorcolumn = '+1'
vim.o.textwidth = 80
vim.o.smartindent = true
vim.o.smarttab = true
set_tab_width(2, 'global')

vim.cmd [[filetype plugin off]]

-- Global options
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
vim.opt.wildignore = {
  '*.avi',
  '*.avif',
  '*.db',
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
  -- '*.env%..*',
  -- '*.env',
}
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
vim.o.wrap = false

-- Autocmds
-- highlight yank for a brief second for visual feedback
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { on_visual = false }
  end,
})
