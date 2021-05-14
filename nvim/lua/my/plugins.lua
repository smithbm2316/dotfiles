-- Require packer.nvim
vim.cmd [[packadd packer.nvim]]
-- Auto compile when the plugins.lua file changes
vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]]

return require('packer').startup(function(use)
  -- *i used the packer.nvim to manage the packer.nvim* - thanos
  use {
    'wbthomason/packer.nvim', opt = true,
  }

  -----------------------------------------------------
  ---
  --- my local plugins
  ---
  -----------------------------------------------------
  use {
    -- '/code/neovim/centerpad.nvim',
    'smithbm2316/centerpad.nvim',
    config = function()
      vim.api.nvim_set_keymap('n', '<leader>z', '<cmd>Centerpad<cr>', { noremap = true, silent = true })
    end,
  }

  -----------------------------------------------------
  ---
  --- lua plugins :D
  ---
  -----------------------------------------------------
  -- the best fuzzy finder :0
  use {
    'nvim-telescope/telescope.nvim',
    -- '~/code/neovim/telescope',
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

  -- easier configuration for built-in neovim lsp
  use {
    'neovim/nvim-lspconfig',
  }

  -- use icons in the completion menus for lsp suggestions
  use {
    'onsails/lspkind-nvim',
  }

  -- show a lightbulb in the gutter where a code action from lsp is available
  use {
    'kosayoda/nvim-lightbulb',
  }

  -- completion plugin
  use {
    'hrsh7th/nvim-compe',
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
    'nvim-treesitter/nvim-treesitter-textobjects',
    requires = 'nvim-treesitter/nvim-treesitter',
  }

  -- tpope/vim-commentary lua replacement
  use {
    'b3nj5m1n/kommentary',
  }

  -- pretty icons for nerd fonts
  use {
    'kyazdani42/nvim-web-devicons',
  }

  -- scratchpad/repl playground for lua
  use {
    'rafcamlet/nvim-luapad',
  }

  -- replacement for alvan/vim-closetag and AndrewRadev/tagalong.vim
  use {
    'windwp/nvim-ts-autotag',
  }

  -- tokyo night colorscheme for fun
  use {
    'folke/tokyonight.nvim',
  }

  -- nice and easy to use statusline
  use {
    'hoob3rt/lualine.nvim',
  }

  -- better quickfix window
  use {
    'kevinhwang91/nvim-bqf',
  }

  -- lazygit in neovim
  use {
    'kdheepak/lazygit.nvim',
    config = function()
      vim.g.lazygit_floating_window_winblend = 0
      vim.g.lazygit_floating_window_use_plenary = 1
      vim.g.lazygit_floating_window_scaling_factor = 0.85
      vim.g.lazygit_use_neovim_remote = 0
      vim.api.nvim_set_keymap('n', '<leader>lg', ':LazyGit<cr>', { noremap = true })
    end,
  }

  -- show preview of colors for hex, hsl, and rgb values
  use {
    'norcalli/nvim-colorizer.lua',
  }

  -- i can't remember my keybinds half the time, this should help
  use {
    'folke/which-key.nvim',
  }

  -- Open a new tab for viewing git diffs for all files in current branch
  use {
    'sindrets/diffview.nvim',
  }

  -- project-specific configuration
  use {
    'windwp/nvim-projectconfig',
    config = function()
      require('nvim-projectconfig').load_project_config()
    end,
  }

  -- view PRs in neovim
  use {
    'pwntester/octo.nvim',
    -- TODO: make this lazy-load (https://github.com/wbthomason/packer.nvim#quickstart)
    -- opt = true,
    config = function()
      require'octo'.setup()
    end,
  }

  -- smooth scrolling in neovim
  use {
    'karb94/neoscroll.nvim',
    config = function()
      require'neoscroll'.setup()
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
  use {
    'rmagatti/session-lens',
    config = function()
      require'session-lens'.setup {
        shorten_path = false,
        prompt_title = 'Pick your saved session',
        winblend = 0,
      }
      vim.api.nvim_set_keymap('n', '<leader>ls', '<cmd>SearchSession<cr>', { noremap = true, silent = true })
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
      -- markdown preview toggle
      vim.api.nvim_set_keymap('n', '<leader>pm', ':MarkdownPreviewToggle<cr>', { noremap = true })
    end,
  }

  -- lua 5.1 manual in vim docs
  use {
    'bfredl/luarefvim',
  }

  -- interactive window resizer
  use {
    'romgrk/winteract.vim',
    config = function()
      vim.api.nvim_set_keymap('n', '<leader>wi', ':InteractiveWindow<cr>', { noremap = true })
    end,
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
    ft = { 'markdown', 'text', 'latex' },
  }

  -- useful for visualizing undos
  use {
    'mbbill/undotree',
  }

  -- tpope's blessings to vimmers everywhere
  -- use {
  --   'tpope/vim-obsession',
  -- }
  use {
    'tpope/vim-surround',
  }
  use {
    'tpope/vim-repeat',
  }
  -- use {
  --   'tpope/vim-fugitive',
  --   config = function()
  --     vim.api.nvim_set_keymap('n', '<leader>gd', ':Gdiffsplit<cr>', { noremap = true, silent = true })
  --     vim.api.nvim_set_keymap('n', '<leader>sg', ':tabnew +vert\\ Git<cr>', { noremap = true, silent = true })
  --   end,
  -- }

  -- language plugins
  use {
    'conornewton/vim-latex-preview',
    ft = 'tex',
    config = function()
      vim.api.nvim_set_keymap('n', '<leader>pl', ':StartLatexPreview<cr>', { noremap = true })
      vim.g.latex_pdf_viewer = 'evince'
      vim.g.latex_engine = 'pdflatex'
    end,
  }

  -- blur the lines between vim and tmux
  use {
    'christoomey/vim-tmux-navigator',
  }

  -- easy access to devdocs.io while in vim
  use {
    'romainl/vim-devdocs',
  }

  -- extra text object for copy/pasting to the system clipboard, its soo good
  use {
    'christoomey/vim-system-copy',
    config = function()
      vim.api.nvim_exec([[
        let g:system_copy#copy_command = 'xclip -sel clipboard'
        let g:system_paste#paste_command = 'xclip -sel clipboard -o'
        let g:system_copy_silent = 1
      ]], false)
    end,
  }

  -- Syntax highlighting plugin
  use {
    'linkinpark342/xonsh-vim', ft = { 'xonsh', 'xsh' },
  }

  -- easier aligning of text
  use {
    'junegunn/vim-easy-align',
    config = function()
      vim.api.nvim_set_keymap('n', 'ga', ':EasyAlign<cr>', { noremap = true })
      vim.api.nvim_set_keymap('v', 'ga', ':EasyAlign<cr>', { noremap = true })
    end,
  }

end)
