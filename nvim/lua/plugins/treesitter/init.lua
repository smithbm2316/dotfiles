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
}
vim.treesitter.language.register('templ', 'templ')

-- blade templates for php filetype
treesitter_parser_config.blade = {
  install_info = {
    url = 'https://github.com/EmranMR/tree-sitter-blade',
    files = { 'src/parser.c' },
    branch = 'main',
  },
}
vim.treesitter.language.register('blade', 'blade')

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
    additional_vim_regex_highlighting = false,
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
    'blade',
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
    'php',
    'prisma',
    'python',
    'query',
    'rust',
    'regex',
    'scss',
    'sql',
    'svelte',
    'teal',
    'templ',
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
