-- quickly print a lua table to :messages
_G.dump = function(...)
  print(vim.inspect(...))
end

-- TODO: add functionality for all ':h map-arguments' options (silent, buffer, etc)
-- wrapper for nvim_set_keymap with sensible defaults
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

-- set a key mapping for normal mode
_G.nnoremap = function(lhs, rhs, opts) keymapper('n', lhs, rhs, opts) end
-- set a key mapping for insert mode
_G.inoremap = function(lhs, rhs, opts) keymapper('i', lhs, rhs, opts) end
-- set a key mapping for visual mode
_G.vnoremap = function(lhs, rhs, opts) keymapper('v', lhs, rhs, opts) end
-- set a key mapping for command-line mode
_G.cnoremap = function(lhs, rhs, opts) keymapper('c', lhs, rhs, opts) end
-- set a key mapping for terminal mode
_G.tnoremap = function(lhs, rhs, opts) keymapper('t', lhs, rhs, opts) end
-- set a key mapping for operator-pending mode
_G.onoremap = function(lhs, rhs, opts) keymapper('o', lhs, rhs, opts) end
-- set a key mapping for insert and command-line mode
_G.icnoremap = function(lhs, rhs, opts) keymapper('!', lhs, rhs, opts) end

-- toggle two windows between vertical and horizontal splits
_G.rotate_windows = function()
  buffers_list = vim.api.nvim_exec('buffers', true)
  for match in buffers_list:gmatch('.*\n') do
    -- TODO: extract the buffer info 'a' for all active buffers and save it
    print(match)
  end
end
