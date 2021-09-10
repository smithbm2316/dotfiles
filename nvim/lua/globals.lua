-- quickly print a table to messages
_G.dump = function(...)
  print(vim.inspect(...))
end

-- wrapper for nvim_set_keymap with sensible defaults
-- TODO: add functionality for all ':h map-arguments' options (silent, buffer, etc)
_G.keymapper = function(mode, lhs, rhs, override_opts)
  local map_args = { 'buffer', 'nowait', 'silent', 'script', 'expr', 'unique' }

  local opts = { noremap = true, silent = true }
  if type(override_opts) == 'string' and override_opts == 'nosilent' then
    opts.silent = false
  elseif type(override_opts) == 'table' then
    vim.tbl_extend('keep', override_opts, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

-- wrappers for specific modes to map
_G.nnoremap = function(lhs, rhs, opts) keymapper('n', lhs, rhs, opts) end
_G.inoremap = function(lhs, rhs, opts) keymapper('i', lhs, rhs, opts) end
_G.vnoremap = function(lhs, rhs, opts) keymapper('v', lhs, rhs, opts) end
_G.cnoremap = function(lhs, rhs, opts) keymapper('c', lhs, rhs, opts) end
_G.tnoremap = function(lhs, rhs, opts) keymapper('t', lhs, rhs, opts) end
_G.onoremap = function(lhs, rhs, opts) keymapper('o', lhs, rhs, opts) end
_G.icnoremap = function(lhs, rhs, opts) keymapper('!', lhs, rhs, opts) end

-- rotate windows between vertical and horizontal setup
_G.rotate_windows = function()
  buffers_list = vim.api.nvim_exec('buffers', true)
  for match in buffers_list:gmatch('.*\n') do
    -- TODO: extract the buffer info 'a' for all active buffers and save it
    print(match)
  end
end
