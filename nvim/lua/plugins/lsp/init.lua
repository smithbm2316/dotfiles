return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'folke/neodev.nvim',
    {
      'pmizio/typescript-tools.nvim',
      enabled = false,
    },
    'jose-elias-alvarez/null-ls.nvim',
  },
  event = 'VeryLazy',
  config = function()
    require 'plugins.lsp.config'
  end,
}
