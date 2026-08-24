require('nvim-treesitter').setup {
  highlight = true,
}

---@class (exact) Language
---@field parser string
---@field ft? string|string[]

---@type (string|Language)[]
local languages = {
  'awk',
  { parser = 'bash', ft = { 'bash', 'sh' } },
  { parser = 'comment' },
  'css',
  'csv',
  'desktop',
  'diff',
  'dockerfile',
  { parser = 'ecma' },
  'go',
  'gomod',
  'gosum',
  'gotmpl',
  'graphql',
  'html',
  { parser = 'html_tags' },
  'http',
  'hurl',
  'ini',
  'javascript',
  'jjdescription',
  'jq',
  'jsdoc',
  'json',
  { parser = 'json5', ft = 'jsonc' },
  { parser = 'jsx' },
  'just',
  'lua',
  { parser = 'luadoc' },
  { parser = 'luap' },
  'make',
  'markdown',
  { parser = 'markdown_inline' },
  'mermaid',
  'query',
  { parser = 'regex' },
  { parser = 'robots_txt', ft = 'robots' },
  { parser = 'printf' },
  'sql',
  { parser = 'ssh_config', ft = 'sshconfig' },
  'sway',
  'templ',
  'toml',
  { parser = 'tsx' },
  'typescript',
  { parser = 'vimdoc', ft = 'help' },
  'xml',
  'yaml',
  'zsh',

  -- 'embedded_template'
  -- 'git_config'
  -- 'git_rebase'
  -- 'gitattributes'
  -- 'gitcommit'
  -- 'gitignore'
  -- 'gpg'
  -- 'jinja'
  -- 'jinja_inline'
  -- 'latex'
  -- 'nginx'
  -- 'odin'
  -- 'passwd'
  -- 'pem'
  -- 'python'
  -- 'readline'
  -- 'scss'
  -- 'styled'
  -- 'sxhkdrc'
  -- 'todotxt'
  -- 'tsv'
  -- 'udev'
  -- 'vim'
  -- 'xresources'
  -- 'zig'
}

---@type string[]
local treesitter_enabled_fts = {}
---@type string[]
local ensure_parsers_installed = {}

for _, lang in ipairs(languages) do
  ---@type string|string[]|nil
  local ft
  ---@type string
  local parser

  if type(lang) == 'string' then
    ft = lang
    parser = lang
  elseif type(lang) == 'table' and type(lang.ft) == 'table' then
    ft = lang.ft[1]
    parser = lang.parser
  elseif type(lang) == 'table' and type(lang.ft) == 'string' then
    ft = lang.ft
    parser = lang.parser
  end

  if ft ~= nil then
    table.insert(treesitter_enabled_fts, ft)
    table.insert(ensure_parsers_installed, parser)
    vim.treesitter.language.register(parser, ft)
  end
end

-- add luax parser
vim.api.nvim_create_autocmd('User', {
  pattern = 'TSUpdate',
  callback = function()
    require('nvim-treesitter.parsers').luax = {
      install_info = {
        url = 'https://github.com/bvisness/bvisness.me',
        location = 'ext/tree-sitter-luax',
      },
    }
  end,
})
table.insert(treesitter_enabled_fts, 'luax')

require('nvim-treesitter').install(ensure_parsers_installed)

vim.api.nvim_create_autocmd('FileType', {
  pattern = treesitter_enabled_fts,
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
