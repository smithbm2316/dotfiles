return {
  'danymat/neogen',
  version = '*',
  cmd = 'Neogen',
  keys = {
    {
      '<leader>ia',
      [[<cmd>Neogen<cr>]],
      desc = 'Insert annotation',
    },
  },
  opts = {
    snippet_engine = 'nvim',
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
