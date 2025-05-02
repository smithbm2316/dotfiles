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

---@type string[] list of filetypes where html features should be enabled
_G.html_like_fts_no_jsx = {
  'astro',
  'blade',
  'django',
  'edge',
  'etlua',
  'gotmpl',
  'html',
  'htmldjango',
  'jinja',
  'jinja.html',
  'liquid',
  'nunjucks',
  'php',
  'templ',
  'tmpl',
  'webc',
}

---@type string[] list of filetypes where html features should be enabled
_G.html_like_fts = vim.tbl_extend('force', _G.html_like_fts_no_jsx, {
  'javascriptreact',
  'svelte',
  'typescriptreact',
  'vue',
})

---@type string[] list of filetypes where css features should be enabled
_G.css_like_fts = {
  'css',
  'less',
  'sass',
  'scss',
  'stylus',
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

--- create an insert-mode mapping that
---@param lhs string the keymap to behind
---@param insert_chars string the characters to insert
---@param lang string the language to include in the help text
---@param should_replace_char boolean? if true, replace the `|` in the `insert_chars` with the cursor
_G.insert_at_cursor_map = function(lhs, insert_chars, lang, should_replace_char)
  vim.keymap.set(
    'i',
    lhs,
    function()
      -- get the current line and cursor position
      local line = vim.api.nvim_get_current_line()
      local cursor = vim.api.nvim_win_get_cursor(0)
      -- insert value of `insert_chars` at the current cursor position in the line
      line = line:sub(1, cursor[2]) .. insert_chars .. line:sub(cursor[2] + 1)
      if not should_replace_char then
        -- prepare the cursor to be `#insert_chars` characters more before I update
        -- the line contents
        cursor[2] = cursor[2] + #insert_chars
      else
        local new_cursor_pos = line:find '|' - 1
        if not new_cursor_pos then
          vim.notify(string.format("Couldn't find `|` in `%s`", insert_chars))
          return
        end
        cursor[2] = new_cursor_pos
        line = string.gsub(line, '|', '')
      end
      -- update the line and cursor position
      vim.api.nvim_set_current_line(line)
      vim.api.nvim_win_set_cursor(0, cursor)
    end,
    { desc = string.format('Insert "%s" (%s) at cursor', insert_chars, lang) }
  )
end

--- sets the appropriate vim settings for tab width in the current buffer. can
--- be scoped to global or buffer local setting
---
---@param tab_width number size to set the tab width to
---@param scope ('global'|'local') whether to use `vim.opt` or `vim.opt_local`
_G.set_tab_width = function(tab_width, scope)
  for _, setting in ipairs { 'shiftwidth', 'softtabstop', 'tabstop' } do
    if scope == 'local' then
      vim.opt_local[setting] = tab_width
    else
      vim.opt[setting] = tab_width
    end
  end
end
