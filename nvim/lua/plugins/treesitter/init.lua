return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    {
      'nvim-treesitter/playground',
      cmd = 'TSPlaygroundToggle',
    },
  },
  lazy = false,
  -- event = 'VeryLazy',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
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
          -- TODO: add JS/TS custom queries for objects and JSX props
          ['aa'] = '@parameter.outer',
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
      -- disable = { 'go', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    },
    matchup = {
      enable = true,
    },
    ensure_installed = {
      'astro',
      'awk',
      'bash',
      'blade',
      'css',
      'csv',
      'diff',
      'dockerfile',
      'embedded_template',
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
      'rasi',
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
  },
  config = function(_, opts)
    local parsers = require('nvim-treesitter.parsers').get_parser_configs()
    -- blade templates for php filetype
    ---@diagnostic disable-next-line: inject-field
    parsers.blade = {
      install_info = {
        url = 'https://github.com/EmranMR/tree-sitter-blade',
        files = { 'src/parser.c' },
        branch = 'main',
      },
      filetype = 'blade',
    }

    -- initialize treesitter
    require('nvim-treesitter.configs').setup(opts)

    -- https://github.com/bennypowers/template-literal-comments.nvim
    vim.treesitter.query.add_directive(
      'set-template-literal-lang-from-comment!',
      function(match, _, bufnr, pred, metadata)
        local comment_node = match[pred[2]]
        if comment_node then
          local success, comment =
            pcall(vim.treesitter.get_node_text, comment_node, bufnr)

          if success then
            local tag = comment:match '/%*%s*(%w+)%s*%*/'
            if tag then
              local language = tag:lower() == 'svg' and 'html'
                or vim.filetype.match { filename = 'a.' .. tag }
                or tag:lower()
              metadata.language = language
            end
          end
        end
      end
    )

    require 'plugins.treesitter.ftdetect'
  end,
  import = 'plugins.treesitter.context',
}
