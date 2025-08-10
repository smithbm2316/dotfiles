require 'options'
require 'globals'
require 'maps.init'
require 'disable-rtp-plugins'

vim.pack.add {
  'https://github.com/catgoose/nvim-colorizer.lua',
  'https://github.com/catppuccin/nvim',
  'https://github.com/christoomey/vim-sort-motion',
  'https://github.com/christoomey/vim-system-copy',
  'https://github.com/christoomey/vim-tmux-navigator',
  'https://github.com/echasnovski/mini.bufremove',
  'https://github.com/echasnovski/mini.icons',
  'https://github.com/echasnovski/mini.pick',
  'https://github.com/laytan/cloak.nvim',
  'https://github.com/lewis6991/gitsigns.nvim', -- mini.diff, mini.git
  'https://github.com/mfussenegger/nvim-lint',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/tpope/vim-repeat',
  'https://github.com/tpope/vim-surround', -- mini.surround
  'https://github.com/vim-scripts/ReplaceWithRegister',
  'https://github.com/windwp/nvim-autopairs', -- mini.pairs
  -- 'mini.ai',
  -- 'mini.comment',
  -- 'mini.fuzzy',
  -- 'mini.indentscope',
  -- 'mini.operators',
  -- 'mini.splitjoin',
  -- 'mini.sessions',
}

require 'diagnostics'
require 'lsp'
require 'treesitter'

-- NICE TO HAVE
-- 01. Jezda1337/nvim-html-css
-- 02. JoosepAlviste/nvim-ts-context-commentstring
-- 03. lukas-reineke/indent-blankline.nvim (mini.indentscope)
-- 04. nvim-treesitter/nvim-treesitter-textobjects (mini.ai)
-- 05. stevearc/dressing.nvim
-- 06. windwp/nvim-ts-autotag

-- VENDOR
-- 01. neovim/nvim-lspconfig
-- 02. steschwa/css-tools.nvim

-- REPLACE
-- 01. rmagatti/auto-session
-- 02. nvim-focus/focus.nvim
-- 03. nvim-telescope/telescope.nvim (mini.pick)
-- 04. nvim-telescope/telescope-fzf-native.nvim (mini.fuzzy)
-- 05. nvim-tree/nvim-web-devicons (mini.icons)

-- REMOVE
-- 01. amadeus/vim-convert-color-to
-- 02. arthurxavierx/vim-caser
-- 03. cameron-wags/rainbow_csv.nvim
-- 04. danymat/neogen
-- 05. folke/todo-comments.nvim
-- 06. folke/trouble.nvim
-- 07. folke/which-key.nvim
-- 08. junegunn/vim-slash
-- 09. nvim-lua/plenary.nvim
-- 10. nvim-lualine/lualine.nvim
-- 11. nvim-treesitter/playground
-- 12. saghen/blink.cmp
-- 13. tpope/vim-dadbod
-- 14. zenbones-theme/zenbones.nvim

-- REMOVE, BUT KEEP CONFIG FOR THESE
-- 01. folke/lazydev.nvim
-- 02. milisims/nvim-luaref
-- 03. nanotee/luv-vimdocs
-- 04. nanotee/nvim-lua-guide
