---@alias ft string the name of a new filetype to create
---@alias file_exts string|string[] a string or list of strings representing a
---file extension
---@alias file_names string[] a list of literal filenames
---@alias file_patterns string[] a list of filename patterns/globs
---@alias ts_parser string a valid treesitter parser to use for a new filetype

---@class (exact) CustomFiletype
---@field filename file_names?
---@field extension file_exts?
---@field pattern file_patterns?
---@field parser ts_parser?

---@type table<ft, CustomFiletype> A table containing new filetype definitions
local fts = {
  env = {
    filename = { '.env' },
    pattern = { '%.env%..*' },
    parser = 'bash',
  },
  ego = {
    extension = 'ego',
    parser = 'embedded_template',
  },
  ejs = {
    extension = 'ejs',
    parser = 'embedded_template',
  },
  etlua = {
    extension = 'etlua',
    parser = 'embedded_template',
  },
  fish = {
    extension = 'fish',
  },
  json = {
    pattern = {
      '.djlintrc',
      '.eslintrc',
      '.parcelrc',
      '.prettierrc',
    },
  },
  jinja = {
    extension = { 'j2', 'jinja' },
    parser = 'twig',
  },
  nunjucks = {
    extension = 'njk',
    parser = 'twig',
  },
  tmpl = {
    extension = 'tmpl',
    parser = 'html',
  },
  templ = {
    extension = 'templ',
  },
  vhs = {
    extension = 'tape',
  },
}

for ft, cfg in pairs(fts) do
  -- if there are any filename patterns to match, loop through all of them and
  -- build the appropriate table structure to be passed to the `pattern` key of
  -- `vim.filetype.add`
  ---@type file_patterns|nil
  local pattern_list = nil
  if cfg.pattern then
    pattern_list = {}
    for _, pattern in ipairs(cfg.pattern) do
      pattern_list[pattern] = ft
    end
  end

  -- if there are any filename literals to match, loop through all of them and
  -- build the appropriate table structure to be passed to the `filename` key of
  -- `vim.filetype.add`
  ---@type file_patterns|nil
  local filename_list = nil
  if cfg.filename then
    filename_list = {}
    for _, filename in ipairs(cfg.filename) do
      filename_list[filename] = ft
    end
  end

  -- set the file extension(s) for the new filetype to be created if there are
  -- any to include in what's passed to the `extension` key of `vim.filetype.add`
  ---@type table<ft, file_exts>|nil
  local extensions = nil
  if cfg.extension then
    extensions = { [ft] = cfg.extension }
  end

  vim.filetype.add {
    filename = filename_list,
    extension = extensions,
    pattern = pattern_list,
  }

  -- if there's a selected treesitter parser to use for this filetype, tell
  -- treesitter to use it on the new custom filetype
  if cfg.parser then
    vim.treesitter.language.add(cfg.parser, {
      filetype = ft,
    })
  end
end
