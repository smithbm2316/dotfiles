-- Require packer.nvim
vim.cmd [[packadd packer.nvim]]
-- Auto compile when the plugins.lua file changes
vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]] 

return require('packer').startup(function()
  -- *i used the packer.nvim to manage the packer.nvim* - thanos
  use { 'wbthomason/packer.nvim', opt = true }

  -- ***** my local plugins *****
  use { '~/code/neovim/restful.nvim' }

  -- ***** lua plugins :D *****
  -- easier configuration for built-in neovim lsp
  use { 'neovim/nvim-lspconfig' }
  -- use icons in the completion menus for lsp suggestions
  use { 'onsails/lspkind-nvim' }
  -- show a lightbulb in the gutter where a code action from lsp is available
  use { 'kosayoda/nvim-lightbulb' }
  -- completion plugin
  use { 'hrsh7th/nvim-compe' }
  -- use { 'nvim-lua/completion-nvim' }
  -- autopairs but better
  use { 'windwp/nvim-autopairs' }
  -- highlight and indent all the things
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSInstall css html javascript typescript tsx bash go c cpp lua python json yaml haskell'
  }
  -- the best fuzzy finder :0
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim',
    }
  }
  
  -- integration with github cli for telescope.nvim
  use {
    'nvim-telescope/telescope-github.nvim',
    requires = 'nvim-telescope/telescope.nvim'
  }

  -- the best fuzzy finder, but my local version of it
  --[[ use {
    '~/code/neovim/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim',
    }
  } ]]

  -- view markdown preview with glow in neovim
  use {
    'npxbr/glow.nvim',
    run = ':GlowInstall'
  }

  -- training tools for getting better at vim
  use { 'ThePrimeagen/vim-be-good' }
  use { 'tjdevries/train.nvim' }

  -- tpope/vim-commentary lua replacement
  use { 'b3nj5m1n/kommentary' }

  

  -- ***** vim plugins *****
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

  -- read github code in Vim without cloning the repo manually
  -- use { 'drzel/vim-repo-edit' }

  -- view/search lsp symbols
  use { 'liuchengxu/vista.vim' }
  
  -- statusline
  use { 'itchyny/lightline.vim' }

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

  -- auto pairs but less annoying
  -- use { 'cohama/lexima.vim' }

  -- for automatic list bulleting when writing markdown or plaintext
  use { 'dkarter/bullets.vim', ft = { 'markdown', 'text', 'latex' } }

  -- useful for visualizing undos
  use { 'mbbill/undotree' }

  -- quick snippets so i don't have to type out unnecessary react and html boilerplate
  -- use { 'SirVer/ultisnips' }

  -- tpope's blessings to vimmers everywhere
  use { 'tpope/vim-abolish' }
  -- use { 'tpope/vim-commentary' }
  use { 'tpope/vim-endwise', ft = { 'lua', 'vim', 'bash', 'zsh', 'sh', 'rb' } }
  use { 'tpope/vim-eunuch' }
  use { 'tpope/vim-obsession' }
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-unimpaired' }
  use { 'tpope/vim-fugitive' }

  -- git stuff
  use { 'airblade/vim-gitgutter' }

  -- language plugins
  -- use { 'fatih/vim-go', run = ':GoInstallBinaries', ft = 'go', }
  use { 'xuhdev/vim-latex-live-preview', ft = 'tex', }

  -- blur the lines between vim and tmux
  use { 'christoomey/vim-tmux-navigator' }

  -- manpages in vim
  -- use { 'jez/vim-superman' }

  -- easy access to devdocs.io while in vim
  use { 'romainl/vim-devdocs' }

  -- todos in vim
  -- use { 'soywod/unfog.vim' }

  -- format my html and javascript code for me please, i'm lazy
  use { 'prettier/vim-prettier', run = 'yarn install', ft = { 'html', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'svelte', 'nunjucks' } }

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
  -- use { 'hail2u/vim-css3-syntax', ft = { 'css', 'scss' } }
  -- use { 'yuezk/vim-js', ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' } }
  -- use { 'HerringtonDarkholme/yats.vim', ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' } }
  -- use { 'maxmellon/vim-jsx-pretty', ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' } }
  -- use { 'neovimhaskell/haskell-vim', ft = { 'haskell', 'lhaskell', 'hs', 'lhs' } }

end)
