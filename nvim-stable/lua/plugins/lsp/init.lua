return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'saghen/blink.cmp',
    'nvim-lua/plenary.nvim',
    {
      'folke/lazydev.nvim',
      -- dependencies = {
      --   -- luvit/uv.[...] types
      --   'Bilal2453/luvit-meta',
      -- },
      lazy = true,
      ft = 'lua',
      opts = {
        runtime = vim.env.VIMRUNTIME,
        -- library = {
        --   {
        --     path = 'luvit-meta/library',
        --     words = { 'vim%.uv' },
        --   },
        -- },
      },
    },
    -- 'pmizio/typescript-tools.nvim',
  },
}
