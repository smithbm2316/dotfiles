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
vim.o.showtabline = 1
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
vim.opt.completeopt = { 'fuzzy', 'menu', 'menuone', 'noinsert' }
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

local disabled_vim_plugins = {
  '2html_plugin',
  'getscript',
  'getscriptPlugin',
  'gzip',
  'logiPat',
  -- 'man',
  -- 'matchit',
  -- 'matchparen',
  'netrw',
  'netrwFileHandlers',
  'netrwPlugin',
  'netrwSettings',
  'remote_plugins',
  'rplugin',
  'rrhelper',
  'shada',
  'shada_plugin',
  'spec',
  -- 'spellfile',
  -- 'spellfile_plugin',
  'tar',
  'tarPlugin',
  'tohtml',
  'tutor',
  'tutor_mode_plugin',
  'vimball',
  'vimballPlugin',
  'zip',
  'zipPlugin',
}

-- disable highlighting pairs for matchup
vim.g.matchup_matchparen_enabled = 0

-- disable remote plugin providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_pythonx_provider = 0
vim.g.loaded_ruby_provider = 0

for _, plugin in ipairs(disabled_vim_plugins) do
  vim.g['loaded_' .. plugin] = 1
end
