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
    -- disable treesitter highlighting for csv/tsv files so that
    -- rainbow_csv.nvim plugin works properly
    disable = {
      'csv',
      'tsv',
      'csv_semicolon',
      'csv_whitespace',
      'csv_pipe',
      'rfc_csv',
      'rfc_semicolon',
      'htmldjango',
      'htmldjango.jinja',
    },
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
    'bash',
    'css',
    'csv',
    'diff',
    'eex',
    'elixir',
    'embedded_template',
    'git_config',
    'git_rebase',
    'gitcommit',
    'gitignore',
    'go',
    'gomod',
    'gosum',
    -- 'gotmpl',
    'graphql',
    'heex',
    'html',
    'htmldjango',
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
    'query',
    'regex',
    'scss',
    'sql',
    'ssh_config',
    'surface',
    'toml',
    'tsx',
    'twig',
    'typescript',
    'vim',
    'vimdoc',
    'xml',
    'yaml',
    -- 'awk',
    -- 'blade',
    -- 'dockerfile',
    -- 'php',
    -- 'php_only',
    -- 'phpdoc',
    -- 'python',
    -- 'rasi',
    -- 'styled',
    -- 'tsv',
  },
}

vim.treesitter.language.register('bash', { 'sh', 'bash', 'zsh' })

-- https://github.com/bennypowers/template-literal-comments.nvim
vim.treesitter.query.add_predicate('is-filetype?', function(_, _, bufnr, pred)
  return vim.bo[bufnr].filetype == pred[2]
end, { force = true })
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
  end,
  { force = true }
)

-- require 'plugins.treesitter.ftdetect'
-- vim.cmd.runtime { 'lua/plugins/treesitter/ftplugins/*.lua', bang = true }

-- auto-update treesitter whenever we update the plugin with vim.pack.update()
vim.api.nvim_create_autocmd('PackChanged', { command = 'TSUpdate' })
