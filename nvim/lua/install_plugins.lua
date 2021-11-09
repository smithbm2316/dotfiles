return require('packer').startup(function(use)
  -- *i used the packer.nvim to manage the packer.nvim* - thanos
  use 'wbthomason/packer.nvim'

  -----------------------------------------------------
  ---
  --- lua plugins :D
  ---
  -----------------------------------------------------
  -- the best fuzzy finder :0
  use {
    'nvim-telescope/telescope.nvim',
    -- '~/code/neovim/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim',
    },
  }

  -- fzf sorting algorithm for telescope
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
  }

  -- easier configuration for built-in neovim lsp
  use 'neovim/nvim-lspconfig'

  -- use icons in the completion menus for lsp suggestions
  use 'onsails/lspkind-nvim'

  -- auto-completion plugin
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
    },
  }

  -- autopairs but better
  use 'windwp/nvim-autopairs'

  -- gitgutter lua replacement
  use {
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
  }

  -- format code with external tools
  use 'mhartington/formatter.nvim'

  -- highlight and indent and textobject all the things
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  use {
    'nvim-treesitter/playground',
    opt = true,
    cmd = 'TSPlaygroundToggle',
  }
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    requires = 'nvim-treesitter/nvim-treesitter',
  }

  -- tpope/vim-commentary lua replacement
  use 'numToStr/Comment.nvim'

  -- add plugin that uses treesitter to figure out what the commentstring should be
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  -- pretty icons for nerd fonts
  use 'kyazdani42/nvim-web-devicons'

  -- replacement for alvan/vim-closetag and AndrewRadev/tagalong.vim
  use {
    'windwp/nvim-ts-autotag',
    opt = true,
    ft = { 'html', 'javascript', 'javascriptreact', 'svelte', 'typescript', 'typescriptreact', 'vue' },
    config = function()
      require 'plugins.opt.autotag'
    end,
  }

  -- nice and easy to use statusline
  use 'nvim-lualine/lualine.nvim'

  -- better quickfix window
  use 'kevinhwang91/nvim-bqf'

  -- show preview of colors for hex, hsl, and rgb values
  use {
    -- 'norcalli/nvim-colorizer.lua',
    -- use the fork until norcalli merges the PR
    'DarwinSenior/nvim-colorizer.lua',
  }

  -- i can't remember my keybinds half the time, this should help
  use 'folke/which-key.nvim'

  -- Open a new tab for viewing git diffs for all files in current branch
  use {
    'sindrets/diffview.nvim',
    opt = true,
    config = function()
      require 'plugins.opt.diffview'
    end,
    cmd = {
      'DiffviewOpen',
      'DiffviewClose',
      'DiffviewFocusFiles',
      'DiffviewToggleFiles',
      'DiffviewRefresh',
    },
  }

  -- project-specific configuration
  use 'windwp/nvim-projectconfig'

  -- view PRs in neovim
  use {
    'pwntester/octo.nvim',
    opt = true,
    cmd = { 'Octo', 'OctoAddReviewComment', 'OctoAddReviewSuggestion' },
    config = function()
      require 'plugins.opt.octo'
    end,
  }

  -- better session management in neovim
  use 'rmagatti/auto-session'

  -- preview window for lsp references/definitions/implementations
  use 'rmagatti/goto-preview'

  -- centerpad, but much better (uses a floating window!!)
  use 'folke/zen-mode.nvim'

  -- highlight todos and other style comments
  use {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
  }

  -- simple file explorer
  use {
    'tamago324/lir.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
  }

  -- luv docs in neovim
  use 'nanotee/luv-vimdocs'

  -- make lua nvim development easier
  use 'folke/lua-dev.nvim'

  -- better tsserver support
  -- language server for linting/formatting
  use {
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    requires = 'jose-elias-alvarez/null-ls.nvim',
  }

  -- snippets
  use 'L3MON4D3/LuaSnip'

  -- for use with neuron zettlekasten manager
  use {
    'oberblastmeister/neuron.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    branch = 'unstable',
    disable = true,
  }

  -- zk cli wrapper for neovim
  use 'megalithic/zk.nvim'

  -- fun colorscheme
  use 'rose-pine/neovim'

  -- change the color of cursorline/cursor on different modes
  use {
    'mvllow/modes.nvim',
    disable = true,
  }

  -- lsp diagnostics in quickfix list
  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
  }

  -- project-local notes
  use 'marcushwz/nvim-workbench'

  -- add indent line guides to editor
  use 'lukas-reineke/indent-blankline.nvim'

  -- semantically select up a level of text to operate on
  use 'RRethy/nvim-treesitter-textsubjects'

  -- rainbow coloring of brackets/curly braces/parenthesis/tags to make finding pairs easier
  use 'p00f/nvim-ts-rainbow'

  -- nice way of managing split focusing
  use 'beauwilliams/focus.nvim'

  -- nicer listing of registers
  use 'tversteeg/registers.nvim'

  -- lightbulb icon to display code actions
  use 'kosayoda/nvim-lightbulb'

  -- Dash.app integration in neovim
  use {
    'mrjones2014/dash.nvim',
    run = 'make install',
    disable = vim.fn.has 'mac' == 0 and true or false,
  }

  -- treesitter-based hinting for selecting a textobject in operator-pending mode
  use 'mfussenegger/nvim-ts-hint-textobject'

  -- nanotee's lua guide reference
  use 'nanotee/nvim-lua-guide'

  -- hey prime I'm testing harpoon like I promised at VimConf
  use 'theprimeagen/harpoon'

  -- git in neovim
  use 'TimUntersberger/neogit'

  -----------------------------------------------------
  ---
  --- vimscript plugins
  ---
  -----------------------------------------------------
  -- markdown previewer in firefox
  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install',
    opt = true,
    cmd = 'MarkdownPreviewToggle',
  }

  -- lua reference
  use 'milisims/nvim-luaref'

  -- runs :noh whenever the mouse cursor is moved 
  use 'junegunn/vim-slash'

  -- for automatic list bulleting when writing markdown or plaintext
  use {
    'dkarter/bullets.vim',
    opt = true,
    ft = { 'markdown', 'text', 'latex', 'tex', 'gitcommit' },
  }

  -- tpope's blessings to vimmers everywhere
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'

  -- color converter for hex to rgb, etc
  use {
    'amadeus/vim-convert-color-to',
    cmd = 'ConvertColorTo',
    opt = true,
  }

  -- blur the lines between vim and tmux
  use 'christoomey/vim-tmux-navigator'

  -- extra operator function for sorting over a textobject or visual range
  use 'christoomey/vim-sort-motion'

  -- extra text object for copy/pasting to the system clipboard, its soo good
  use 'christoomey/vim-system-copy'

  -- replace with register
  use 'vim-scripts/ReplaceWithRegister'

  -- golang support
  use 'fatih/vim-go'

  -----------------------------------------------------
  ---
  --- syntax highlighting plugins
  ---
  -----------------------------------------------------
  -- lua
  use 'euclidianAce/BetterLua.vim'

  -- i3wm config
  use 'mboughaba/i3config.vim'
end)
