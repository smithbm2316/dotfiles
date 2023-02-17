-- TODO: set up parameter textobjects, so I can swap elements in a lua table back and forth cc TJ's recent stream
local ok = pcall(require, 'nvim-treesitter')
if not ok then
  return
end

-- local ft_to_parser = require('nvim-treesitter.parsers').filetype_to_parsername
-- ft_to_parser.nunjucks = 'tsx'
-- ft_to_parser.liquid = 'tsx'

-- temporary until this PR gets merged: https://github.com/nvim-treesitter/nvim-treesitter/pull/3726
local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.vhs = {
  install_info = {
    url = 'https://github.com/charmbracelet/tree-sitter-vhs', -- local path or git repo
    files = { 'src/parser.c' },
    -- optional entries:
    branch = 'main', -- default branch in case of git repo if different from master
    generate_requires_npm = false, -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = true, -- if folder contains pre-generated src/parser.c
  },
  filetype = 'vhs', -- if filetype does not match the parser name
}

require('nvim-treesitter.configs').setup {
  textobjects = {
    enable = true,
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
        ['aa'] = '@parameter.outer', -- TODO: add JS/TS custom queries for objects and JSX props
        ['ia'] = '@parameter.inner',
      },
    },
  },
  textsubjects = {
    enable = true,
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
    },
  },
  rainbow = {
    enable = false,
    extended_mode = false,
    colors = {
      '#eb6f92',
      '#f6c177',
      '#ea9a97',
      '#3e8fb0',
      '#9ccfd8',
      '#c4a7e7',
      '#817c9c',
    },
    max_file_lines = nil,
  },
  playground = {
    enable = true,
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { 'BufWrite', 'CursorHold' },
  },
  -- nvim-ts-context-commentstring setup
  context_commentstring = {
    enable = false,
    enable_autocmd = false,
    config = {
      javascript = {
        __default = '// %s',
        jsx_element = '{/* %s */}',
        jsx_fragment = '{/* %s */}',
        jsx_attribute = '// %s',
        comment = '// %s',
        __parent = {
          -- if a node has this as the parent, use the `//` commentstring
          jsx_expression = '// %s',
        },
      },
    },
  },
  autopairs = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
    -- https://github.com/nvim-treesitter/nvim-treesitter/issues/2369
    -- waiting on this issue with indents to be resolved from nvim-treesitter
    disable = { 'go', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  },
  ensure_installed = {
    'astro',
    'bash',
    'comment',
    'css',
    'dockerfile',
    'fish',
    'go',
    'gomod',
    'graphql',
    'html',
    'http',
    'javascript',
    'jsdoc',
    'json',
    'jsonc',
    'lua',
    'markdown',
    'markdown_inline',
    'prisma',
    'python',
    'query',
    'rust',
    'regex',
    'scss',
    'sql',
    'svelte',
    'teal',
    'toml',
    'tsx',
    'typescript',
    'vue',
    'vhs',
    'vim',
    -- 'yaml', this currently is breaking the Telescope previewer
  },
}

-- require submodule of context
pcall(require, 'plugins.treesitter.context')
