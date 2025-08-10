return {
  'folke/todo-comments.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-lua/plenary.nvim',
  },
  event = 'VeryLazy',
  opts = {
    highlight = {
      exclude = { 'vim' },
    },
  },
}
