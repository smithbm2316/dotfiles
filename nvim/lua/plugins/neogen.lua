return {
  'danymat/neogen',
  version = '*',
  dependencies = {
    'L3MON4D3/LuaSnip',
  },
  cmd = 'Neogen',
  keys = {
    {
      '<leader>ia',
      [[<cmd>Neogen<cr>]],
      desc = 'Insert annotation',
    },
  },
  opts = {
    languages = {
      lua = {
        template = {
          annotation_convention = 'emmylua',
        },
      },
      typescript = {
        template = {
          annotation_convention = 'tsdoc',
        },
      },
      typescriptreact = {
        template = {
          annotation_convention = 'tsdoc',
        },
      },
    },
  },
}
