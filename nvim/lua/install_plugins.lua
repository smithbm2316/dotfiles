return require('packer').startup {
  function(use)
    -- *i used the packer.nvim to manage the packer.nvim* - thanos
    use 'wbthomason/packer.nvim'

    -----------------------------------------------------
    ---
    --- lua plugins :D
    ---
    -----------------------------------------------------
    -- markdown preview in floating buffer, courtesy of glow
    use 'ellisonleao/glow.nvim'

    -- paste to your heart's content
    -- use 'hrsh7th/nvim-pasta'

    -- export my current set of buffers to vsc*de for when i need a real debugger or need to use the
    -- typescript translator extension
    -- use 'elijahmanor/export-to-vscode.nvim'

    -- reverse J using treesitter now
    -- use 'AckslD/nvim-trevJ.lua'

    -- lsp server progress indicator
    use 'j-hui/fidget.nvim'

    -- annotation generator
    use 'danymat/neogen'

    -- lua development with types
    use 'folke/lua-dev.nvim'

    -- handle git diffs in neovim
    -- use 'akinsho/git-conflict.nvim'

    -- select from a list of URLs in the current file
    -- use 'axieax/urlview.nvim'

    -- magit inside of neovim
    use 'TimUntersberger/neogit'

    -- better menus for inputs and selects in neovim
    use 'stevearc/dressing.nvim'

    -- mini plugins that do one thing well
    -- specifically installing for bufremove overrides
    use {
      'echasnovski/mini.nvim',
      branch = 'stable',
    }

    -- better notifications
    use 'rcarriga/nvim-notify'

    -- treesitter info for my statusline
    -- use 'SmiteshP/nvim-gps'

    -- nicer listing of registers
    use 'tversteeg/registers.nvim'

    -- nice way of managing split focusing
    use 'beauwilliams/focus.nvim'

    -- rainbow coloring of brackets/curly braces/parenthesis/tags to make finding pairs easier
    use 'p00f/nvim-ts-rainbow'

    -- add indent line guides to editor
    use 'lukas-reineke/indent-blankline.nvim'

    -- colorscheme
    use 'rose-pine/neovim'

    -- snippets
    use 'L3MON4D3/LuaSnip'

    -- language server for linting/formatting
    -- better tsserver support
    use {
      'jose-elias-alvarez/nvim-lsp-ts-utils',
      requires = 'jose-elias-alvarez/null-ls.nvim',
    }

    -- simple file explorer
    use 'tamago324/lir.nvim'

    -- folke plugins
    -- centerpad, but much better (uses a floating window!!)
    use 'folke/zen-mode.nvim'
    -- i can't remember my keybinds half the time, this should help
    use 'folke/which-key.nvim'

    -- preview window for lsp references/definitions/implementations
    use 'rmagatti/goto-preview'

    -- better session management in neovim
    use 'rmagatti/auto-session'

    -- Open a new tab for viewing git diffs for all files in current branch
    use {
      'sindrets/diffview.nvim',
      opt = true,
      cmd = { 'DiffviewOpen', 'DiffviewFiles' },
      config = function()
        require 'plugins.opt.diffview'
      end,
    }

    -- show preview of colors for hex, hsl, and rgb values
    use {
      -- 'norcalli/nvim-colorizer.lua',
      -- use the fork until norcalli merges the PR
      'DarwinSenior/nvim-colorizer.lua',
    }

    -- better quickfix window
    use {
      'kevinhwang91/nvim-bqf',
    }

    -- nice and easy to use statusline
    use 'nvim-lualine/lualine.nvim'

    -- replacement for alvan/vim-closetag and AndrewRadev/tagalong.vim
    use 'windwp/nvim-ts-autotag'

    -- pretty icons for nerd fonts
    use 'kyazdani42/nvim-web-devicons'

    -- add plugin that uses treesitter to figure out what the commentstring should be
    -- use 'JoosepAlviste/nvim-ts-context-commentstring'

    -- tpope/vim-commentary lua replacement
    use {
      'numToStr/Comment.nvim',
      branch = 'jsx',
    }

    -- highlight and indent and textobject all the things
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
    }
    use {
      'nvim-treesitter/nvim-treesitter-textobjects',
      requires = 'nvim-treesitter/nvim-treesitter',
    }
    use {
      'nvim-treesitter/playground',
      opt = true,
      cmd = 'TSPlaygroundToggle',
    }

    -- format code with external tools
    use 'mhartington/formatter.nvim'

    -- gitgutter lua replacement
    use {
      'lewis6991/gitsigns.nvim',
      requires = 'nvim-lua/plenary.nvim',
    }

    -- autopairs but better
    use 'windwp/nvim-autopairs'

    -- auto-completion plugin
    use {
      'hrsh7th/nvim-cmp',
      requires = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
        -- 'hrsh7th/cmp-buffer',
        -- 'hrsh7th/cmp-nvim-lua',
      },
    }

    -- use icons in the completion menus for lsp suggestions
    use 'onsails/lspkind-nvim'

    -- easier configuration for built-in neovim lsp
    use 'neovim/nvim-lspconfig'

    -- fzf sorting algorithm for telescope
    use {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
    }

    -- TJ's lua functions that he doesn't wanna write again
    use 'nvim-lua/plenary.nvim'

    -- notetaking with golang zk lsp
    use 'mickael-menu/zk-nvim'

    -- the best fuzzy finder :0
    -- use '~/code/neovim/telescope.nvim'
    use 'nvim-telescope/telescope.nvim'

    -- impatient speeds up loading times with caching
    use 'lewis6991/impatient.nvim'

    -----------------------------------------------------
    ---
    --- vimscript plugins
    ---
    -----------------------------------------------------
    -- manage DBs in vim
    use 'tpope/vim-dadbod'

    -- manage DBs in vim
    use 'kristijanhusak/vim-dadbod-ui'

    -- runs :noh whenever the mouse cursor is moved 
    use 'junegunn/vim-slash'

    -- for automatic list bulleting when writing markdown or plaintext
    use {
      'dkarter/bullets.vim',
      opt = true,
      ft = { 'markdown', 'text', 'latex', 'tex', 'gitcommit' },
      config = function()
        vim.g.bullets_outline_levels = { 'ROM', 'ABC', 'num', 'abc', 'rom', 'std-' }
      end,
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

    -- kmonad config
    use 'kmonad/kmonad-vim'

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
  end,
  config = {
    compile_path = vim.fn.stdpath 'config' .. '/lua/packer/packer_compiled.lua',
    display = {
      open_fn = require('packer.util').float,
    },
  },
}
