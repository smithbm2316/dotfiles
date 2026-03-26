require('nvim-treesitter').setup {
  highlight = true,
}

local ensure_installed = {
  'bash',
  'css',
  'csv',
  'diff',
  -- 'eex',
  -- 'elixir',
  'embedded_template',
  'git_config',
  'git_rebase',
  'gitcommit',
  'gitignore',
  'go',
  'gomod',
  'gosum',
  'gotmpl',
  'graphql',
  -- 'heex',
  'html',
  'htmldjango',
  'http',
  'ini',
  'javascript',
  'jq',
  'jsdoc',
  'json',
  -- 'jsonc',
  'lua',
  'luadoc',
  'luap',
  'markdown',
  'markdown_inline',
  'mermaid',
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
}

local filetypes = {
  'bash',
  'css',
  'csv',
  'diff',
  'git_config',
  'git_rebase',
  'gitcommit',
  'gitignore',
  'go',
  'gomod',
  'gosum',
  'gotmpl',
  'graphql',
  'html',
  'htmldjango',
  'http',
  'ini',
  'javascript',
  'javascriptreact',
  'jq',
  'jsdoc',
  'json',
  -- 'jsonc',
  'lua',
  'luadoc',
  'luap',
  'markdown',
  'query',
  'regex',
  'scss',
  'sql',
  'ssh_config',
  'surface',
  'toml',
  'twig',
  'typescript',
  'typescriptreact',
  'vim',
  'vimdoc',
  'xml',
  'yaml',
}

require('nvim-treesitter').install(ensure_installed)

vim.treesitter.language.register('bash', { 'sh', 'bash', 'zsh' })

vim.api.nvim_create_autocmd('FileType', {
  pattern = filetypes,
  callback = function()
    -- syntax highlighting, provided by Neovim
    vim.treesitter.start()
    -- folds, provided by Neovim
    -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    -- vim.wo.foldmethod = 'expr'
    -- indentation, provided by nvim-treesitter
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

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
