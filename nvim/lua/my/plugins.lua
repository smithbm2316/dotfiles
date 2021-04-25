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
    run = ':TSUpdate',
  }

  -- the best fuzzy finder :0
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim',
    }
  }

  -- the best fuzzy finder, but my local version of it
  --[[ use {
    '~/code/neovim/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim',
    }
  } ]]

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

  -- pretty icons for nerd fonts
  use { 'kyazdani42/nvim-web-devicons' }

  -- scratchpad/repl playground for lua
  use { 'rafcamlet/nvim-luapad' }

  -- replacement for goyo.vim, allows for making UI elements disappear/centering file in window
  use {
    'kdav5758/TrueZen.nvim',
    config = function()
      vim.api.nvim_set_keymap('n', '<leader>z', ':TZAtaraxis<cr>', { noremap = true })
    end
  }

  -- replacement for alvan/vim-closetag and AndrewRadev/tagalong.vim
  use { 'windwp/nvim-ts-autotag' }

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

  -- netrw replacement
  -- use {
    -- 'lambdalisue/fern.vim',
    -- config = function()
      -- vim.api.nvim_exec([[
        -- let g:fern#renderer = "nerdfont"
        -- augroup my-glyph-palette
          -- autocmd! *
          -- autocmd FileType fern call glyph_palette#apply()
        -- augroup END
        -- autocmd FileType fern set nonumber norelativenumber
      -- ]], false)
    -- end,
  -- }
  
  --[[ use { 
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
  } ]]

  -- lua 5.1 manual in vim docs
  use { 'bfredl/luarefvim' }

  -- MOAR TEXT OBJECTS!!
  use { 'wellle/targets.vim' }

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

  -- a reminder of what my leader remaps are
  use {
    'liuchengxu/vim-which-key',
    config = function()
      vim.api.nvim_set_keymap('n', '<leader>', ":WhichKey '<leader>'<cr>", { noremap = true, silent = true })
    end,
  }

  -- pretty css colors everywhere
  use {
    'RRethy/vim-hexokinase',
    run = 'make',
    config = function()
      vim.g.Hexokinase_optInPatterns = 'full_hex,rgb,rgba,hsl,hsla'
    end,
  }

  -- for automatic list bulleting when writing markdown or plaintext
  use {
    'dkarter/bullets.vim',
    ft = { 'markdown', 'text', 'latex' },
  }

  -- useful for visualizing undos
  use { 'mbbill/undotree' }

  -- tpope's blessings to vimmers everywhere
  use { 'tpope/vim-obsession' }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-repeat' }
  use {
    'tpope/vim-fugitive',
    config = function()
      vim.api.nvim_set_keymap('n', '<leader>gd', ':Gdiffsplit<cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>sg', ':tabnew +vert\\ Git<cr>', { noremap = true, silent = true })
    end,
  }

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
  use { 'christoomey/vim-tmux-navigator' }

  -- easy access to devdocs.io while in vim
  use { 'romainl/vim-devdocs' }

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

  -- more useful text objects
  use { 'kana/vim-textobj-user' }
  use { 'coachshea/vim-textobj-markdown' }
  use { 'Julian/vim-textobj-variable-segment' }

  -- Syntax highlighting plugin
  use { 'linkinpark342/xonsh-vim', ft = 'xonsh' }

end)
