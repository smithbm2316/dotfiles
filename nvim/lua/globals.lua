---@type string[] list of filetypes where html features should be enabled
_G.html_like_fts_no_jsx = {
  'astro',
  'blade',
  'gohtml',
  'html',
  'htmldjango',
  'htmldjango.jinja',
  'jinja',
  'liquid',
  'nunjucks',
  'php',
  'tmpl',
}

---@type string[] list of filetypes where html features should be enabled
_G.html_like_fts = vim.list_extend(
  { 'javascriptreact', 'typescriptreact' },
  _G.html_like_fts_no_jsx
)

---@type string[] list of filetypes where css features should be enabled
_G.css_like_fts = {
  'css',
  'less',
  'sass',
  'scss',
}

---@type string[] list of filetypes to enable JS/TS features for
_G.js_ts_fts = {
  'javascript',
  'javascriptreact',
  'typescript',
  'typescriptreact',
}

--- record of config files like eslint and prettier that i might want to match
--- against on the local filesystem
_G.config_files = {
  eslint = {
    'eslint.config.js',
    'eslint.config.cjs',
    'eslint.config.mjs',
    '.eslintrc',
    '.eslintrc.cjs',
    '.eslintrc.js',
    '.eslintrc.json',
    '.eslintrc.yaml',
    '.eslintrc.yml',
  },
  prettier = {
    '.prettierrc',
    '.prettierignore',
    '.prettierrc.json',
    '.prettierrc.js',
    'prettier.config.js',
  },
}

_G.diagnostic_icons = {
  [vim.diagnostic.severity.ERROR] = '!', -- '',
  [vim.diagnostic.severity.WARN] = '?', -- '',
  [vim.diagnostic.severity.INFO] = '@', -- '󱠃',
  [vim.diagnostic.severity.HINT] = '*', -- '',
}

-- quickly print a lua table to :messages
_G.dump = function(obj, use_notify)
  if use_notify then
    vim.notify(obj, vim.log.levels.DEBUG, { timeout = false })
  else
    print(vim.inspect(obj))
  end
  return obj
end

---@param patterns string[]
---@return boolean
_G.root_pattern = function(patterns)
  for name, type in vim.fs.dir '.' do
    if type == 'file' and vim.tbl_contains(patterns, name) then
      return true
    end
  end

  return false
end
