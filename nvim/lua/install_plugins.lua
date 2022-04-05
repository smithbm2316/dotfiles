return require('packer').startup {
  function(use)
    -- *i used the packer.nvim to manage the packer.nvim* - thanos
    use 'wbthomason/packer.nvim'

    -----------------------------------------------------
    ---
    --- lua plugins :D
    ---
    -----------------------------------------------------
    --{{{
    -- impatient speeds up loading times with caching
    use 'lewis6991/impatient.nvim'

    -- the best fuzzy finder :0
    use 'nvim-telescope/telescope.nvim'
    -- use '~/code/neovim/telescope.nvim'

    -- notetaking with golang zk lsp
    use 'mickael-menu/zk-nvim'

    -- TJ's lua functions that he doesn't wanna write again
    use 'nvim-lua/plenary.nvim'

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
        'hrsh7th/cmp-nvim-lua',
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
    use {
      'kevinhwang91/nvim-bqf',
    }

    -- show preview of colors for hex, hsl, and rgb values
    use {
      -- 'norcalli/nvim-colorizer.lua',
      -- use the fork until norcalli merges the PR
      'DarwinSenior/nvim-colorizer.lua',
    }

    -- i can't remember my keybinds half the time, this should help
    use 'folke/which-key.nvim'

    -- Open a new tab for viewing git diffs for all files in current branch
    use 'sindrets/diffview.nvim'

    -- better session management in neovim
    use 'rmagatti/auto-session'

    -- preview window for lsp references/definitions/implementations
    use 'rmagatti/goto-preview'

    -- centerpad, but much better (uses a floating window!!)
    use 'folke/zen-mode.nvim'

    -- highlight todos and other style comments
    use 'folke/todo-comments.nvim'

    -- simple file explorer
    use 'tamago324/lir.nvim'

    -- better tsserver support
    -- language server for linting/formatting
    use {
      'jose-elias-alvarez/nvim-lsp-ts-utils',
      requires = 'jose-elias-alvarez/null-ls.nvim',
    }

    -- snippets
    use 'L3MON4D3/LuaSnip'

    -- colorscheme
    use 'rose-pine/neovim'

    -- add indent line guides to editor
    use 'lukas-reineke/indent-blankline.nvim'

    -- rainbow coloring of brackets/curly braces/parenthesis/tags to make finding pairs easier
    use 'p00f/nvim-ts-rainbow'

    -- nice way of managing split focusing
    use 'beauwilliams/focus.nvim'

    -- nicer listing of registers
    use 'tversteeg/registers.nvim'

    -- lazygit in neovim
    -- use 'kdheepak/lazygit.nvim'

    -- treesitter info for my statusline
    use 'SmiteshP/nvim-gps'

    -- better notifications
    use 'rcarriga/nvim-notify'

    -- mini plugins that do one thing well
    -- specifically installing for bufremove overrides
    use {
      'echasnovski/mini.nvim',
      branch = 'stable',
    }

    -- better menus for inputs and selects in neovim
    use 'stevearc/dressing.nvim'

    -- magit inside of neovim
    use 'TimUntersberger/neogit'

    -- select from a list of URLs in the current file
    -- use '~/code/urlview.nvim'
    use 'axieax/urlview.nvim'

    -- handle git diffs in neovim
    use 'akinsho/git-conflict.nvim'

    -- status info for lsp
    use 'nvim-lua/lsp-status.nvim'

    -- lua development with types
    use 'folke/lua-dev.nvim'

    --}}}
    -----------------------------------------------------
    ---
    --- vimscript plugins
    ---
    -----------------------------------------------------
    --{{{

    -- copilot *not* in vscode??
    use {
      'github/copilot.vim',
      opt = true,
      cmd = 'Copilot',
      setup = function()
        vim.g.copilot_enabled = 0
      end,
    }

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

    -- switch casing of selected text
    use 'arthurxavierx/vim-caser'

    -----------------------------------------------------
    ---
    --- syntax highlighting plugins
    ---
    -----------------------------------------------------
    -- i3wm config
    use 'mboughaba/i3config.vim'

    -----------------------------------------------------
    ---
    --- documentation plugins
    ---
    -----------------------------------------------------
    -- luv docs in neovim
    use 'nanotee/luv-vimdocs'

    -- nanotee's lua guide reference
    use 'nanotee/nvim-lua-guide'

    -- lua reference
    use 'milisims/nvim-luaref'
    --}}}
  end,
  config = {
    compile_path = vim.fn.stdpath 'config' .. '/lua/packer/packer_compiled.lua',
    display = {
      open_fn = require('packer.util').float,
    },
  },
}
