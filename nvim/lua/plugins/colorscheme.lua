return {
  'catppuccin/nvim',
  name = 'catppuccin',
  dependencies = {
    'neanias/everforest-nvim',
  },
  priority = 1000,
  lazy = false,
  config = function()
    require('catppuccin').setup {
      flavour = 'mocha', -- latte, frappe, macchiato, mocha
      -- :h background
      -- background = {
      --   light = 'latte',
      --   dark = 'mocha',
      -- },
      transparent_background = false,
      show_end_of_buffer = false, -- show the '~' characters after the end of buffers
      term_colors = false,
      dim_inactive = {
        enabled = false,
        shade = 'dark',
        percentage = 0.15,
      },
      no_italic = false, -- Force no italic
      no_bold = false, -- Force no bold
      no_underline = false, -- Force no underline
      styles = {
        comments = { 'italic' },
        conditionals = { 'italic' },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      color_overrides = {},
      custom_highlights = {},
      integrations = {
        cmp = true,
        dap = true,
        harpoon = true,
        gitsigns = true,
        markdown = true,
        mini = true,
        neogit = true,
        -- native_lsp = true,
        notify = true,
        nvimtree = false,
        treesitter = true,
        treesitter_context = true,
        ts_rainbow = true,
        telekasten = true,
        telescope = true,
        lsp_trouble = true,
        which_key = true,
      },
    }
    require('everforest').setup {
      ---Controls the "hardness" of the background. Options are "soft", "medium" or "hard".
      ---Default is "medium".
      background = 'light',
    }

    if vim.opt.background:get() == 'dark' then
      vim.cmd [[colorscheme catppuccin-mocha]]
    else
      vim.cmd [[colorscheme everforest]]
    end

    -- switch between light/dark theme
    vim.keymap.set('n', '<leader>tt', function()
      if vim.opt.background:get() == 'dark' then
        vim.opt.background = 'light'
        vim.cmd [[colorscheme everforest]]
      else
        vim.opt.background = 'dark'
        vim.cmd [[colorscheme catppuccin-mocha]]
      end
    end, { desc = 'Toggle color mode' })
  end,
}
