-- TODO: set up parameter textobjects, so I can swap elements in a lua table back and forth cc TJ's recent stream
local ok = pcall(require, 'nvim-treesitter')
if not ok then
  return
end

local treesitter_parser_config = require('nvim-treesitter.parsers').get_parser_configs()

-- golang templ template filetype
treesitter_parser_config.templ = {
  install_info = {
    url = 'https://github.com/vrischmann/tree-sitter-templ.git',
    files = { 'src/parser.c', 'src/scanner.c' },
    branch = 'master',
  },
  filetype = 'templ',
}

-- blade templates for php filetype
treesitter_parser_config.blade = {
  install_info = {
    url = 'https://github.com/EmranMR/tree-sitter-blade',
    files = { 'src/parser.c' },
    branch = 'main',
  },
  filetype = 'blade',
}

treesitter_parser_config.webc = {
  install_info = {
    url = '~/code/tree-sitter-webc',
    files = { 'src/parser.c', 'src/scanner.c' },
    branch = 'main',
  },
  filetype = 'webc',
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
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    -- https://github.com/nvim-treesitter/nvim-treesitter/issues/2369
    -- waiting on this issue with indents to be resolved from nvim-treesitter
    disable = { 'go', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  },
  matchup = {
    enable = true, -- mandatory, false will disable the whole extension
    -- disable = {},  -- optional, list of language that will be disabled
    -- [options]
  },
  ensure_installed = {
    'astro',
    'awk',
    'bash',
    'blade',
    'comment',
    'css',
    'csv',
    'diff',
    'dockerfile',
    'git_config',
    'git_rebase',
    'gitcommit',
    'gitignore',
    'go',
    'gomod',
    'gosum',
    'graphql',
    'html',
    'http',
    'ini',
    'javascript',
    'jq',
    'jsdoc',
    'json',
    'jsonc',
    'lua',
    'luadoc',
    'luap',
    'markdown',
    'markdown_inline',
    'php',
    'phpdoc',
    'php_only',
    'python',
    'query',
    'regex',
    'scss',
    'sql',
    'ssh_config',
    'styled',
    'templ',
    'toml',
    'tsv',
    'tsx',
    'twig',
    'typescript',
    'vhs',
    'vim',
    'vimdoc',
    'xml',
    'yaml',
  },
}

-- require submodule of context
pcall(require, 'plugins.treesitter.context')

-- https://github.com/bennypowers/template-literal-comments.nvim
vim.treesitter.query.add_directive('set-template-literal-lang-from-comment!', function(match, _, bufnr, pred, metadata)
  local comment_node = match[pred[2]]
  if comment_node then
    local success, comment = pcall(vim.treesitter.get_node_text, comment_node, bufnr)
    if success then
      local tag = comment:match '/%*%s*(%w+)%s*%*/'
      if tag then
        local language = tag:lower() == 'svg' and 'html' or vim.filetype.match { filename = 'a.' .. tag } or tag:lower()
        metadata.language = language
      end
    end
  end
end)
