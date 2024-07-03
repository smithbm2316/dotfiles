local version = vim.version()

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'folke/neodev.nvim',
      enabled = version.minor < 10,
      lazy = true,
      ft = 'lua',
      opts = {
        library = {
          enabled = true,
          runtime = true,
          types = true,
          plugins = true,
        },
        setup_jsonls = true,
        pathStrict = true,
      },
    },
    {
      'folke/lazydev.nvim',
      enabled = version.minor >= 10,
      dependencies = {
        -- lapis web framework types
        'Sylviettee/lapis-annotations',
        -- luvit/uv.[...] types
        'Bilal2453/luvit-meta',
      },
      lazy = true,
      ft = 'lua',
      opts = {
        library = {
          {
            path = 'lapis-annotations/library',
            mods = { 'lapis' },
            words = { 'lapis', 'GET', 'POST', 'PUT', 'DELETE' },
          },
          {
            path = 'luvit-meta/library',
            words = { 'vim%.uv' },
          },
        },
      },
    },
    'pmizio/typescript-tools.nvim',
    'jose-elias-alvarez/null-ls.nvim',
  },
  event = 'VeryLazy',
  config = function()
    require 'plugins.lsp.config'
  end,
}
