---@type string[] list of filetypes where html features should be enabled
_G.html_like_fts_no_jsx = {
  'blade',
  'gotmpl',
  'html',
  'jinja',
  'liquid',
  'nunjucks',
  'php',
  'tmpl',
}

---@type string[] list of filetypes where html features should be enabled
_G.html_like_fts = vim.tbl_extend('force', _G.html_like_fts_no_jsx, {
  'javascriptreact',
  'typescriptreact',
})

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

-- override `vim.notify` globally to ignore the annoying error below from
-- getting printed to my `:messages`
local notify = vim.notify
vim.notify = function(msg, ...)
  if msg:match 'Inlay Hints request failed. File not opened' then
    return
  end
  notify(msg, ...)
end
