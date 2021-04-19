-- Require packer.nvim
vim.cmd [[packadd packer.nvim]]
-- Auto compile when the plugins.lua file changes
vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]] 

return require('packer').startup(function()
  -- *i used the packer.nvim to manage the packer.nvim* - thanos
  use { 'wbthomason/packer.nvim', opt = true }

  -----------------------------------------------------
  ---
  --- my local plugins
  ---
  -----------------------------------------------------
  use { '~/code/neovim/restful.nvim' }

  -----------------------------------------------------
  ---
  --- lua plugins :D 
  ---
  -----------------------------------------------------
  -- easier configuration for built-in neovim lsp
  use { 'neovim/nvim-lspconfig' }

  -- use icons in the completion menus for lsp suggestions
  use { 'onsails/lspkind-nvim' }

  -- show a lightbulb in the gutter where a code action from lsp is available
  use { 'kosayoda/nvim-lightbulb' }

  -- completion plugin
  use { 'hrsh7th/nvim-compe' }

  -- autopairs but better
  use { 'windwp/nvim-autopairs' }

  -- gitgutter lua replacement
  use {
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim'
  }

  -- format code with external tools
  use { 'mhartington/formatter.nvim' }

  -- highlight and indent all the things
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSInstall css html javascript typescript tsx bash go c cpp lua python json yaml haskell'
  }

  -- the best fuzzy finder :0
  --[[ use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim',
    }
  } ]]

  -- the best fuzzy finder, but my local version of it
  use {
    '~/code/neovim/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim',
    }
  }

  -- integration with github cli for telescope.nvim
  use {
    'nvim-telescope/telescope-github.nvim',
  }

  -- fzf sorting algorithm for telescope
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  }

  -- tpope/vim-commentary lua replacement
  use { 'b3nj5m1n/kommentary' }
  
  -----------------------------------------------------
  ---
  --- vimscript plugins
  ---
  -----------------------------------------------------
  -- markdown previewer in firefox
  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install'
  }

  -- netrw replacement
  use { 
    'lambdalisue/fern-git-status.vim',
    requires = 'lambdalisue/fern.vim'
  }

  use {
    'lambdalisue/fern-renderer-nerdfont.vim',
    requires = {
      'lambdalisue/fern.vim',
      'lambdalisue/nerdfont.vim',
      'lambdalisue/glyph-palette.vim'
    }
  }

  use {
    'lambdalisue/fern-hijack.vim',
    requires = 'lambdalisue/fern.vim'
  }

  -- Makes f/F and t/T searching better!
  use { 'rhysd/clever-f.vim' }

  -- MOAR TEXT OBJECTS!!
  use { 'wellle/targets.vim' }

  -- interactive window resizer
  use { 'romgrk/winteract.vim' }

  -- remove lots of the vim frills when I want to write text
  use { 'junegunn/goyo.vim' }

  -- runs :noh whenever the mouse cursor is moved 
  use { 'junegunn/vim-slash' }

  -- pretty icons for nerd fonts
  use { 'kyazdani42/nvim-web-devicons' }

  -- a reminder of what my leader remaps are
  use { 'liuchengxu/vim-which-key' }

  -- pretty css colors everywhere
  use { 'RRethy/vim-hexokinase', run = 'make' }

  -- make editing html a tolerable experience
  use { 'alvan/vim-closetag', ft = { 'html', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'svelte', 'nunjucks' } }
  use { 'AndrewRadev/tagalong.vim', ft = { 'html', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'svelte', 'nunjucks' } }

  -- for automatic list bulleting when writing markdown or plaintext
  use { 'dkarter/bullets.vim', ft = { 'markdown', 'text', 'latex' } }

  -- useful for visualizing undos
  use { 'mbbill/undotree' }

  -- tpope's blessings to vimmers everywhere
  use { 'tpope/vim-endwise', ft = { 'lua', 'vim', 'bash', 'zsh', 'sh', 'rb' } }
  use { 'tpope/vim-obsession' }
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-unimpaired' }
  use { 'tpope/vim-fugitive' }

  -- language plugins
  use { 'xuhdev/vim-latex-live-preview', ft = 'tex' }

  -- blur the lines between vim and tmux
  use { 'christoomey/vim-tmux-navigator' }

  -- easy access to devdocs.io while in vim
  use { 'romainl/vim-devdocs' }

  -- extra text object for copy/pasting to the system clipboard, its soo good
  use { 'christoomey/vim-system-copy' }

  -- more useful text objects
  use { 'kana/vim-textobj-user' }
  use { 'coachshea/vim-textobj-markdown' }
  use { 'Julian/vim-textobj-variable-segment' }

  -- use a motion before pasting from my register
  use { 'vim-scripts/ReplaceWithRegister' }

  -- Syntax highlighting plugin
  use { 'linkinpark342/xonsh-vim', ft = 'xonsh' }
  use { 'cespare/vim-toml' }

end)
