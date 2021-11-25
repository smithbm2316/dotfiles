-- TODO: set up parameter textobjects, so I can swap elements in a lua table back and forth cc TJ's recent stream
local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

--[[ parser_config.astro = {
  install_info = {
    url = 'https://github.com/theHamsta/tree-sitter-html',
    files = { 'src/parser.c', 'src/scanner.cc' },
    branch = 'astro',
  },
} --]]

require('nvim-treesitter.configs').setup {
  textobjects = {
    disable = { 'markdown' },
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
    disable = { 'markdown' },
  },
  rainbow = {
    enable = true,
    disable = { 'markdown' },
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
    disable = { 'markdown' },
  },
  query_linter = {
    enable = true,
    disable = { 'markdown' },
    use_virtual_text = true,
    lint_events = { 'BufWrite', 'CursorHold' },
  },
  -- nvim-ts-context-commentstring setup
  context_commentstring = {
    enable = true,
    disable = { 'markdown' },
    enable_autocmd = false,
  },
  autopairs = {
    enable = true,
    disable = { 'markdown' },
  },
  autotag = {
    enable = true,
  },
  highlight = {
    enable = true,
    disable = { 'astro', 'markdown' },
  },
  indent = {
    enable = true,
    disable = { 'astro', 'markdown' },
  },
  ensure_installed = {
    'bash',
    'c',
    'cmake',
    'comment',
    'cpp',
    'css',
    'dockerfile',
    'fish',
    'go',
    'gomod',
    'graphql',
    'html',
    'javascript',
    'jsdoc',
    'json',
    'jsonc',
    'lua',
    'python',
    'query',
    'regex',
    'scss',
    'svelte',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'vue',
    'yaml',
  },
}
