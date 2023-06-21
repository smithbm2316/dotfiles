return require('packer').startup {
  function(use)
    -- *i used the packer.nvim to manage the packer.nvim* - thanos
    use { 'wbthomason/packer.nvim' }

    -----------------------------------------------------
    ---
    --- lua plugins :D
    ---
    -----------------------------------------------------
    -- vim.notify handler
    use {
      'vigoux/notifier.nvim',
    }

    -- see the current function/class's context
    use {
      'nvim-treesitter/nvim-treesitter-context',
    }

    -- annotation generator
    use {
      'danymat/neogen',
    }

    -- handle git diffs in neovim
    use {
      'akinsho/git-conflict.nvim',
      disable = true,
    }

    -- better menus for inputs and selects in neovim
    use {
      'stevearc/dressing.nvim',
    }

    -- mini plugins that do one thing well
    -- specifically installing for bufremove overrides
    use {
      'echasnovski/mini.nvim',
      branch = 'stable',
    }

    -- nice way of managing split focusing
    use {
      'nvim-focus/focus.nvim',
    }

    -- rainbow coloring of brackets/curly braces/parenthesis/tags to make finding pairs easier
    use {
      'p00f/nvim-ts-rainbow',
    }

    -- add indent line guides to editor
    use {
      'lukas-reineke/indent-blankline.nvim',
    }

    -- snippets
    use {
      'L3MON4D3/LuaSnip',
    }

    -- better tsserver support
    use {
      'jose-elias-alvarez/nvim-lsp-ts-utils',
      requires = 'jose-elias-alvarez/null-ls.nvim',
    }
    -- language server for linting/formatting/code actions/more
    use {
      'jose-elias-alvarez/null-ls.nvim',
    }

    -- file browser like vim-vinegar
    use {
      'stevearc/oil.nvim',
    }

    -- folke plugins
    -- i can't remember my keybinds half the time, this should help
    use {
      'folke/which-key.nvim',
    }
    -- lua development with types
    use {
      'folke/neodev.nvim',
    }
    -- run lsp server for whole project or just the file
    use {
      'folke/trouble.nvim',
    }

    -- preview window for lsp references/definitions/implementations
    use {
      'rmagatti/goto-preview',
    }

    -- better session management in neovim
    use {
      'rmagatti/auto-session',
    }

    -- Open a new tab for viewing git diffs for all files in current branch
    use {
      'sindrets/diffview.nvim',
    }

    -- show preview of colors for hex, hsl, and rgb values
    use {
      -- 'norcalli/nvim-colorizer.lua',
      -- use the fork until norcalli merges the PR
      -- 'DarwinSenior/nvim-colorizer.lua',
      -- NvChad project has re-written this with no external dependencies!
      'NvChad/nvim-colorizer.lua',
    }

    -- better quickfix window
    use {
      'kevinhwang91/nvim-bqf',
    }

    -- nice and easy to use statusline
    use {
      'nvim-lualine/lualine.nvim',
    }

    -- replacement for alvan/vim-closetag and AndrewRadev/tagalong.vim
    use {
      'windwp/nvim-ts-autotag',
    }

    -- pretty icons for nerd fonts
    use {
      'kyazdani42/nvim-web-devicons',
    }

    -- tpope/vim-commentary lua replacement
    use {
      'numToStr/Comment.nvim',
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
    }

    -- gitgutter lua replacement
    use {
      'lewis6991/gitsigns.nvim',
      requires = 'nvim-lua/plenary.nvim',
    }

    -- autopairs but better
    use {
      'windwp/nvim-autopairs',
    }

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
    use {
      'onsails/lspkind-nvim',
    }

    -- easier configuration for built-in neovim lsp
    use {
      'neovim/nvim-lspconfig',
    }

    -- TJ's lua functions that he doesn't wanna write again
    use {
      'nvim-lua/plenary.nvim',
    }

    -- the best fuzzy finder :0
    use {
      'nvim-telescope/telescope.nvim',
    }
    -- fzf sorting algorithm for telescope
    use {
      'nvim-telescope/telescope-fzf-native.nvim',
      requires = 'nvim-telescope/telescope.nvim',
      run = 'make',
    }
    -- file browser with telescope
    use {
      'nvim-telescope/telescope-file-browser.nvim',
      requires = 'nvim-telescope/telescope.nvim',
    }
    -- zettlekasten notetaking workflow supercharged with telescope!
    use {
      'renerocksai/telekasten.nvim',
    }

    -- impatient speeds up loading times with caching
    use {
      'lewis6991/impatient.nvim',
    }

    -- open help menu in a vsplit
    use {
      'anuvyklack/help-vsplit.nvim',
      config = function()
        require('help-vsplit').setup {
          always = true, -- Always open help in a vertical split.
          side = 'left', -- 'left' or 'right'
          buftype = { 'help' },
          filetype = { 'man' },
        }
      end,
    }

    -----------------------------------------------------
    ---
    --- colorscheme plugins
    ---
    -----------------------------------------------------
    use {
      '4e554c4c/darkman.nvim',
      run = 'go build -o bin/darkman.nvim',
    }

    use {
      'rose-pine/neovim',
    }

    use {
      'catppuccin/nvim',
      as = 'catppuccin',
    }

    use {
      'maxmx03/fluoromachine.nvim',
    }

    -----------------------------------------------------
    ---
    --- vimscript plugins
    ---
    -----------------------------------------------------
    -- manage DBs in vim
    use {
      'tpope/vim-dadbod',
    }

    -- manage DBs in vim
    use {
      'kristijanhusak/vim-dadbod-ui',
    }

    -- runs :noh whenever the mouse cursor is moved 
    use {
      'junegunn/vim-slash',
    }

    -- tpope's blessings to vimmers everywhere
    use {
      'tpope/vim-surround',
    }
    use {
      'tpope/vim-repeat',
    }

    -- color converter for hex to rgb, etc
    use {
      'amadeus/vim-convert-color-to',
    }

    -- blur the lines between vim and tmux
    use {
      'christoomey/vim-tmux-navigator',
    }

    -- extra operator function for sorting over a textobject or visual range
    use {
      'christoomey/vim-sort-motion',
    }

    -- extra text object for copy/pasting to the system clipboard, its soo good
    use {
      'christoomey/vim-system-copy',
    }

    -- replace with register
    use {
      'vim-scripts/ReplaceWithRegister',
    }

    -- switch casing of selected text
    use {
      'arthurxavierx/vim-caser',
    }

    -----------------------------------------------------
    ---
    --- syntax highlighting plugins
    ---
    -----------------------------------------------------
    -- i3wm config
    use {
      'mboughaba/i3config.vim',
    }

    -- kmonad config
    use {
      'kmonad/kmonad-vim',
    }

    -- rasi filetype
    use {
      'Fymyte/rasi.vim',
    }

    -----------------------------------------------------
    ---
    --- documentation plugins
    ---
    -----------------------------------------------------
    -- luv docs in neovim
    use {
      'nanotee/luv-vimdocs',
    }

    -- nanotee's lua guide reference
    use {
      'nanotee/nvim-lua-guide',
    }

    -- lua reference
    use {
      'milisims/nvim-luaref',
    }
  end,
  config = {
    compile_path = vim.fn.stdpath 'config' .. '/lua/packer/packer_compiled.lua',
    display = {
      open_fn = require('packer.util').float,
    },
  },
}
