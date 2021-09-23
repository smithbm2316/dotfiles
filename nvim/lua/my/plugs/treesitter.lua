-- TODO: set up parameter textobjects, so I can swap elements in a lua table back and forth cc TJ's recent stream
local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

parser_config.astro = {
  install_info = {
    url = 'https://github.com/theHamsta/tree-sitter-html',
    files = { 'src/parser.c', 'src/scanner.cc' },
    branch = 'astro',
  },
}

require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@conditional.outer',
        ['ic'] = '@conditional.inner',
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
      },
    },
    lsp_interop = {
      enable = true,
    },
    -- move = {
    --   enable = true,
    --   goto_next_start = {
    --     ['<leader>nf'] = '@function.outer',
    --   },
    --   goto_previous_start = {
    --     ['<leader>pf'] = '@function.outer',
    --   },
    -- },
  },
  textsubjects = {
    enable = true,
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
    }
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    colors = {
      '#eb6f92',
      '#f6c177',
      '#ea9a97',
      '#3e8fb0',
      '#9ccfd8',
      '#c4a7e7',
      '#817c9c',
    },
    -- max_file_lines = nil,
  },
  playground = {
    enable = true,
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = {'BufWrite', 'CursorHold'},
  },
  -- nvim-ts-context-commentstring setup
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  ensure_installed = 'maintained',
}

-- set mappings for lsp peek definition for functions and classes with treesitter
nnoremap('<leader>hf', '<cmd>TSTextobjectPeekDefinitionCode @function.outer<cr>')
nnoremap('<leader>hc', '<cmd>TSTextobjectPeekDefinitionCode @class.outer<cr>')
