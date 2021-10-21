return require('packer').startup(function(use)
  -- *i used the packer.nvim to manage the packer.nvim* - thanos
  use {
    'wbthomason/packer.nvim'
  }

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
    }
  }

  -- fzf sorting algorithm for telescope
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  }

  -- easier configuration for built-in neovim lsp
  use {
    'neovim/nvim-lspconfig',
  }

  -- use icons in the completion menus for lsp suggestions
  use {
    'onsails/lspkind-nvim',
  }

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
  use {
    'windwp/nvim-autopairs',
  }

  -- gitgutter lua replacement
  use {
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim'
  }

  -- format code with external tools
  use {
    'mhartington/formatter.nvim',
  }

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
  use {
    'numToStr/Comment.nvim',
  }

  -- add plugin that uses treesitter to figure out what the commentstring should be
  use {
    'JoosepAlviste/nvim-ts-context-commentstring',
  }

  -- pretty icons for nerd fonts
  use {
    'kyazdani42/nvim-web-devicons',
  }

  -- replacement for alvan/vim-closetag and AndrewRadev/tagalong.vim
  use {
    'windwp/nvim-ts-autotag',
    opt = true,
    ft = { 'html', 'javascript', 'javascriptreact', 'svelte', 'typescript', 'typescriptreact', 'vue' },
    config = function()
      require('my.plugs.ts-autotag')
    end,
  }

  -- nice and easy to use statusline
  use {
    'shadmansaleh/lualine.nvim',
  }

  -- better quickfix window
  use {
    'kevinhwang91/nvim-bqf',
  }

  -- lazygit in neovim
  use {
    'kdheepak/lazygit.nvim',
    setup = function()
      vim.api.nvim_set_keymap('n', '<leader>gs', '<cmd>LazyGit<cr>', { noremap = true, silent = true })
    end,
    opt = true,
    cmd = { 'LazyGit', 'LazyGitConfig', 'LazyGitFilter' },
  }

  -- show preview of colors for hex, hsl, and rgb values
  use {
    -- 'norcalli/nvim-colorizer.lua',
    -- use the fork until norcalli merges the PR
    'DarwinSenior/nvim-colorizer.lua',
  }

  -- i can't remember my keybinds half the time, this should help
  use {
    'folke/which-key.nvim',
  }

  -- Open a new tab for viewing git diffs for all files in current branch
  use {
    'sindrets/diffview.nvim',
    opt = true,
    config = function()
      require('my.plugs.diffview')
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
  use {
    'windwp/nvim-projectconfig',
    setup = function()
      -- set up cmd to edit project config
      vim.cmd [[command! ProjectConfig lua require'nvim-projectconfig'.edit_project_config()]]
    end,
    config = function()
      require('nvim-projectconfig').load_project_config {
        project_dir = '~/dotfiles/nvim/projects/'
      }
    end,
  }

  -- view PRs in neovim
  use {
    'pwntester/octo.nvim',
    opt = true,
    cmd = { 'Octo', 'OctoAddReviewComment', 'OctoAddReviewSuggestion' },
    config = function()
      require('octo').setup()
    end,
  }

  -- better session management in neovim
  use {
    'rmagatti/auto-session',
    config = function()
      require'auto-session'.setup {
        log_level = 'error',
        auto_session_root_dir = vim.fn.stdpath('config') .. '/sessions/',
      }
    end,
  }

  -- centerpad, but much better (uses a floating window!!)
  use {
    'folke/zen-mode.nvim',
  }

  -- highlight todos and other style comments
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end
  }

  -- simple file explorer
  use {
    'tamago324/lir.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
  }

  -- luv docs in neovim
  use {
    'nanotee/luv-vimdocs',
  }

  -- make lua nvim development easier
  use {
    'folke/lua-dev.nvim',
  }

  -- better tsserver support
  -- language server for linting/formatting
  use {
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    requires = 'jose-elias-alvarez/null-ls.nvim',
  }

  -- snippets
  use {
    'L3MON4D3/LuaSnip',
  }

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
  use {
    'megalithic/zk.nvim',
  }

  -- fun colorscheme
  use {
    'rose-pine/neovim',
  }

  -- change the color of cursorline/cursor on different modes
  use {
    'mvllow/modes.nvim',
    disable = true,
    config = function()
      require('modes').setup {
        colors = {
          copy = "#f5c359",
          delete = "#c75c6a",
          insert = "#78ccc5",
          visual = "#9745be",
        },
        line_opacity = 0.1
      }
    end,
  }

  -- lsp diagnostics in quickfix list
  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require'trouble'.setup {}
      vim.api.nvim_set_keymap('n', '<leader>ld', '<cmd>TroubleToggle lsp_document_diagnostics<cr>', { noremap = true, silent = true })
    end,
  }

  -- project-local notes
  use {
    'marcushwz/nvim-workbench',
    config = function()
      vim.api.nvim_set_keymap('n', '<leader>wp', '<Plug>ToggleProjectWorkbench', { silent = true })
      vim.api.nvim_set_keymap('n', '<leader>wb', '<Plug>ToggleBranchWorkbench', { silent = true })
      vim.api.nvim_set_keymap('n', '<leader>wt', '<Plug>WorkbenchToggleCheckbox', { silent = true })
    end,
  }

  -- add indent line guides to editor
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require 'indent_blankline'.setup {
        -- show_current_context = true,
        buftype_exclude = { 'terminal', 'man' },
        filetype_exclude = { 'help', 'man', 'startuptime', 'qf', 'lspinfo' },
        char_highlight_list = {
          'IndentBlanklineIndent1',
        },
      }
      vim.cmd 'hi IndentBlanklineIndent1 guifg=#312f44 blend=nocombine'
    end,
  }

  -- semantically select up a level of text to operate on
  use {
    'RRethy/nvim-treesitter-textsubjects',
  }

  -- rainbow coloring of brackets/curly braces/parenthesis/tags to make finding pairs easier
  use {
    'p00f/nvim-ts-rainbow',
  }

  -- clipboard manager for vim registers
  use {
    'AckslD/nvim-neoclip.lua',
    config = function()
      require'neoclip'.setup {
        history = 500,
        filter = function(...)
          -- event, filetype, buffer_name params from neoclip
          local _, ft, buf_name = ...
          -- don't save yanks from .env files
          if ft == 'sh' and buf_name:match('.env') then
            return false
          else
            return true
          end
        end,
        preview = true,
        default_register = '"',
        content_spec_column = false,
        on_paste = {
          set_reg = false,
        },
        keys = {
          i = {
            select = '<cr>',
            paste = '<c-p>',
            paste_behind = '<c-k>',
          },
          n = {
            select = '<cr>',
            paste = 'p',
            paste_behind = 'P',
          },
        },
      }
    end,
  }

  -- script runner/test playground for code
  use {
    'jbyuki/dash.nvim',
    config = function()
      -- playground run
      vim.api.nvim_set_keymap(
        'n',
        '<leader>pr',
        [[<cmd>lua require'dash'.execute_buf()<cr>]],
        { silent = true, noremap = true }
      )
      -- playground lua
      vim.api.nvim_set_keymap(
        'n',
        '<leader>pl',
        [[<cmd>vnew | set ft=lua<cr>]],
        { silent = true, noremap = true }
      )
    end
  }

  -- nice way of managing split focusing
  use {
    'beauwilliams/focus.nvim',
    config = function()
      require'focus'.setup()
    end,
  }









  -----------------------------------------------------
  ---
  --- vimscript plugins
  ---
  -----------------------------------------------------
  -- markdown previewer in firefox
  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install',
    config = function()
      -- Set default browser to open in
      vim.g.mkdp_browser = 'firefox'
      -- Print the preview url in the command line output
      vim.g.mkdp_echo_preview_url = 1
      -- Start markdown preview server on port 5000
      vim.g.mkdp_port = 5000
    end,
    opt = true,
    cmd = 'MarkdownPreviewToggle',
  }

  use {
    'milisims/nvim-luaref',
  }

  -- runs :noh whenever the mouse cursor is moved 
  use {
    'junegunn/vim-slash',
    config = function()
      vim.cmd 'noremap <plug>(slash-after) zz'
    end,
  }

  -- for automatic list bulleting when writing markdown or plaintext
  use {
    'dkarter/bullets.vim',
    opt = true,
    ft = { 'markdown', 'text', 'latex', 'tex' },
  }

  -- tpope's blessings to vimmers everywhere
  use {
    'tpope/vim-surround',
  }
  use {
    'tpope/vim-repeat',
  }

  -- blur the lines between vim and tmux
  use {
    'christoomey/vim-tmux-navigator',
  }

  -- easy access to devdocs.io while in vim
  use {
    'romainl/vim-devdocs',
    opt = true,
    cmd = 'DD',
  }

  -- extra text object for copy/pasting to the system clipboard, its soo good
  use {
    'christoomey/vim-system-copy',
    config = function()
      if vim.fn.has('mac') == 1 then
        vim.g['system_copy#copy_command'] = 'pbcopy'
        vim.g['system_paste#paste_command'] = 'pbpaste'
      else
        vim.g['system_copy#copy_command'] = 'xclip -sel clipboard'
        vim.g['system_paste#paste_command'] = 'xclip -sel clipboard -o'
      end
      vim.g['system_copy_silent'] = 1
    end,
  }

  -- easier aligning of text
  use {
    'junegunn/vim-easy-align',
    setup = function()
      vim.api.nvim_set_keymap('n', 'ga', '<cmd>EasyAlign<cr>', { noremap = true })
      vim.api.nvim_set_keymap('v', 'ga', '<cmd>EasyAlign<cr>', { noremap = true })
    end,
    opt = true,
    cmd = { 'EasyAlign' },
  }

  -- color converter for hex to rgb, etc
  use {
    'amadeus/vim-convert-color-to',
  }

end)
