-- TODO: set up parameter textobjects, so I can swap elements in a lua table back and forth cc TJ's recent stream
local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

-- neorg treesitter module
-- parser_config.norg = {
--   install_info = {
--     url = "https://github.com/vhyrro/tree-sitter-norg",
--     files = { "src/parser.c" },
--     branch = "main"
--   },
-- }

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
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
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
vim.api.nvim_set_keymap('n', '<leader>hf', '<cmd>TSTextobjectPeekDefinitionCode @function.outer<cr>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>hc', '<cmd>TSTextobjectPeekDefinitionCode @class.outer<cr>', { silent = true, noremap = true })
