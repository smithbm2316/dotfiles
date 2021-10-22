-- allows you to run nv.*insert vim.api method name here*() without the `nvim_` prefix
-- example: nv.get_current_buf()
_G.nv = setmetatable({}, {
  __index = function(_, key)
    return vim.api['nvim_' .. key]
  end,
})

-- quickly print a lua table to :messages
_G.dump = function(...)
  print(vim.inspect(...))
end

-- TODO: add functionality for all ':h map-arguments' options (silent, buffer, etc)
-- wrapper for nvim_set_keymap with sensible defaults
local keymapper = function(mode, lhs, rhs, override_opts)
  local map_args = { 'buffer', 'nowait', 'silent', 'script', 'expr', 'unique' }

  local opts = { noremap = true, silent = true }
  if type(override_opts) == 'string' and override_opts == 'nosilent' then
    opts.silent = false
  elseif type(override_opts) == 'table' then
    vim.tbl_extend('keep', override_opts, opts)
  end
  nv.set_keymap(mode, lhs, rhs, opts)
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
  buffers_list = nv.exec('buffers', true)
  for match in buffers_list:gmatch('.*\n') do
    -- TODO: extract the buffer info 'a' for all active buffers and save it
    print(match)
  end
end

--[[
-- https://github.com/norcalli/nvim_utils/blob/71919c2f05920ed2f9718b4c2e30f8dd5f167194/lua/nvim_utils.lua#L240
_G.nvim = setmetatable({
  print = function(...)
    print(vim.inspect(...))
  end,
}, {
  __index = function(t, key)
    local mt = getmetatable(t)
    local x = mt[key]
    if x ~= nil then
      return x
    end
    local f = vim.api['nvim_' .. key]
    mt[key] = f
    return f
  end,
})
--]]