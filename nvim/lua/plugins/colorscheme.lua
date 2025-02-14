return {
  'catppuccin/nvim',
  name = 'catppuccin',
  dependencies = {
    'zenbones-theme/zenbones.nvim',
  },
  priority = 1000,
  lazy = false,
  config = function()
    -- disable lush integration for zenbones
    vim.g.bones_compat = 1

    require('catppuccin').setup {
      flavour = 'mocha', -- latte, frappe, macchiato, mocha
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
        blink_cmp = true,
        cmp = false,
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

    local background_to_colorscheme = {
      light = 'seoulbones',
      dark = 'catppuccin',
    }

    -- https://emmer.dev/blog/automate-your-macos-defaults/
    -- https://www.reddit.com/r/neovim/comments/1d3hk1t/automatic_dark_mode_following_system_theme_on/
    if vim.uv.os_uname().sysname == 'Darwin' then
      -- Check if 'defaults' is executable
      if vim.fn.executable 'defaults' ~= 0 then
        -- Execute command to check if the macOS appearance is set to Dark
        local appleInterfaceStyle =
          vim.fn.system { 'defaults', 'read', '-g', 'AppleInterfaceStyle' }
        if appleInterfaceStyle:find 'Dark' then
          vim.opt.background = 'dark'
        else
          vim.opt.background = 'light'
        end
      end
    else
      vim.opt.background = 'dark'
    end

    vim.cmd(
      'colorscheme '
        .. background_to_colorscheme[vim.opt.background:get() or 'dark']
    )

    vim.keymap.set('n', '<leader>tt', function()
      local new_colorscheme = vim.opt.background:get() == 'dark' and 'light'
        or 'dark'
      vim.opt.background = new_colorscheme
      vim.cmd('colorscheme ' .. background_to_colorscheme[new_colorscheme])
    end, { desc = 'Toggle color mode' })
  end,
}
