---------------------------
---------------------------
----- Augroup helpers -----
---------------------------
---------------------------
-- global table with all my user-created aucmds
_G.BSAugroups = {}

-- helper for creating a new augroup and autocmds along with a toggler
_G.create_augroup = function(group, aucmds)
  -- create new augroup
  vim.api.nvim_create_augroup(group, {
    clear = true,
  })

  -- create this augroup's entry in the global table if it doesn't exist
  if not _G.BSAugroups[group] then
    _G.BSAugroups[group] = {
      enabled = true,
      aucmds = aucmds,
    }
  end

  -- loop through the table of aucmds and create each one
  for _, aucmd in ipairs(aucmds) do
    -- add the current augroup name to the autocmd config table
    local aucmd_config = vim.tbl_extend('keep', { group = group }, aucmd)
    -- remove events key from config to pass to autocmd API function
    aucmd_config.events = nil
    vim.api.nvim_create_autocmd(aucmd.events, aucmd_config)
  end
end

---helper function to toggle an augroup on/off
---@param group string name of autogroup to toggle
_G.toggle_augroup = function(group)
  if _G.BSAugroups[group].enabled then
    _G.BSAugroups[group].enabled = false
    vim.api.nvim_del_augroup_by_name(group)
    vim.notify('Disabled ' .. group)
  else
    _G.BSAugroups[group].enabled = true
    create_augroup(group, _G.BSAugroups[group].aucmds)
    vim.notify('Enabled ' .. group)
  end
end

-------------------------------
-------------------------------
----- Print table wrapper -----
-------------------------------
-------------------------------
-- quickly print a lua table to :messages
_G.dump = function(obj, use_notify)
  if use_notify then
    vim.notify(obj, vim.log.levels.DEBUG, { timeout = false })
  else
    print(vim.inspect(obj))
  end
  return obj
end

local diagnostic_severity_shortnames = { 'Error', 'Warn', 'Hint', 'Info' }
_G.diagnostic_icons = {
  error = '',
  warn = '',
  hint = '󱠃',
  info = '',
}

_G.glp = function(path)
  local file_path = require('plenary.path'):new { path, sep = '/' }
  if not file_path:exists() then
    return nil
  end
  return file_path:absolute()
end

_G.get_css_files = function()
  return vim.split(vim.fn.globpath(vim.fn.getcwd(), '**/*.css'), '\n')
end

--- list of filetypes where html-like features should be enabled
_G.html_like_fts = {
  'astro',
  'blade',
  'django',
  'edge',
  'etlua',
  'gohtml',
  'gohtmltmpl',
  'html',
  'htmldjango',
  'javascript',
  'javascriptreact',
  'jinja',
  'jinja.html',
  'liquid',
  'nunjucks',
  'php',
  'templ',
  'typescript',
  'typescriptreact',
}

--- Checks if any of the provided filenames exist in the current working
--- directory
---@param ... string The filenames to check in the cwd
---@return boolean
_G.exists_in_cwd = function(...)
  local file_exists = false
  for _, file in ipairs { ... } do
    local stat = vim.loop.fs_stat(file)
    if stat and stat.type == 'file' then
      file_exists = true
      break
    end
  end
  return file_exists
end

_G.bs = {
  telescope = {
    ignored = {},
    always_ignored = {},
  },
}
