-- Require packer.nvim
vim.cmd [[packadd packer.nvim]]
-- Auto compile when the plugins.lua file changes
vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]]

return require('packer').startup(function(use)
  local reqplug = function(name)
    return require('my.plugs.' .. name)
  end
  -- *i used the packer.nvim to manage the packer.nvim* - thanos
  use {
    'wbthomason/packer.nvim', opt = true,
  }

  -----------------------------------------------------
  ---
  --- my plugins
  ---
  -----------------------------------------------------

  -----------------------------------------------------
  ---
  --- lua plugins :D
  ---
  -----------------------------------------------------
  -- the best fuzzy finder :0
  use {
    -- 'nvim-telescope/telescope.nvim',
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
    opt = true,
    cmd = { 'FormatWrite', 'Format' },
    config = function()
      reqplug('formatter')
    end,
  }

  -- highlight and indent and textobject all the things
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  use {
    'nvim-treesitter/playground',
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
    opt = true,
    cmd = { 'Luapad', 'Lua', 'LuaRun' },
  }

  -- replacement for alvan/vim-closetag and AndrewRadev/tagalong.vim
  use {
    'windwp/nvim-ts-autotag',
    opt = true,
    ft = { 'html', 'javascript', 'javascriptreact', 'svelte', 'typescript', 'typescriptreact', 'vue' },
    config = function()
      reqplug('ts-autotag')
    end,
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
    setup = function()
      vim.api.nvim_set_keymap('n', '<leader>gs', '<cmd>LazyGit<cr>', { noremap = true, silent = true })
    end,
    config = function()
      vim.g.lazygit_floating_window_winblend = 0
      vim.g.lazygit_floating_window_use_plenary = 1
      vim.g.lazygit_floating_window_scaling_factor = 0.85
      vim.g.lazygit_use_neovim_remote = 0
    end,
    opt = true,
    cmd = { 'LazyGit', 'LazyGitConfig', 'LazyGitFilter' },
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
    config = function()
      require('my.plugs.diffview')
    end,
  }

  -- project-specific configuration
  use {
    'windwp/nvim-projectconfig',
    setup = function()
      vim.api.nvim_set_keymap('n', '<leader>pc', [[<cmd>lua require'nvim-projectconfig'.edit_project_config()<cr>]], { noremap = true, silent = true })
    end,
    config = function()
      require('nvim-projectconfig').load_project_config()
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

  -- smooth scrolling in neovim
  use {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup()
      require('neoscroll.config').set_mappings({
        ['<C-y>'] = { 'scroll', { '-0.05', 'false', '20' } },
        ['<C-e>'] = { 'scroll', { '0.05', 'false', '20' } },
      })
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

  -- centerpad, but much better (uses a floating window!!)
  use {
    'folke/zen-mode.nvim',
  }

  -- pretty list for showing lsp info
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end
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
  }

  -- luv docs in neovim
  use {
    'nanotee/luv-vimdocs',
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
    opt = true,
    ft = { 'markdown', 'text', 'latex' },
  }

  -- tpope's blessings to vimmers everywhere
  use {
    'tpope/vim-surround',
  }
  use {
    'tpope/vim-repeat',
  }

  -- language plugins
  use {
    'conornewton/vim-latex-preview',
    setup = function()
      vim.api.nvim_set_keymap('n', '<leader>pl', ':StartLatexPreview<cr>', { noremap = true })
    end,
    config = function()
      vim.g.latex_pdf_viewer = 'evince'
      vim.g.latex_engine = 'pdflatex'
    end,
    opt = true,
    ft = 'tex',
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
      vim.g['system_copy#copy_command'] = 'xclip -sel clipboard'
      vim.g['system_paste#paste_command'] = 'xclip -sel clipboard -o'
      vim.g['system_copy_silent'] = 1
    end,
  }

  -- Syntax highlighting plugin
  use {
    'linkinpark342/xonsh-vim',
    opt = true,
    ft = { 'xonsh', 'xsh' },
  }

  -- easier aligning of text
  use {
    'junegunn/vim-easy-align',
    setup = function()
      vim.api.nvim_set_keymap('n', 'ga', '<cmd>EasyAlign<cr>', { noremap = true })
      vim.api.nvim_set_keymap('v', 'ga', '<cmd>EasyAlign<cr>', { noremap = true })
    end,
    opt = true,
    cmd = 'EasyAlign',
  }

end)
