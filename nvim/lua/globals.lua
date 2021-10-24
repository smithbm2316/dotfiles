-- allows you to run nv.*insert vim.api method name here*() without the `nvim_` prefix
-- example: nv.get_current_buf()
-- TODO: make cmp completion source for this
-- example: https://github.com/hrsh7th/cmp-nvim-lua/blob/main/lua/cmp_nvim_lua/init.lua
_G.nv = setmetatable({}, {
  __index = function(_, key)
    return vim.api['nvim_' .. key]
  end,
})

-- quickly print a lua table to :messages
_G.dump = function(...)
  print(vim.inspect(...))
end

-- wrapper for nvim_set_keymap with sensible defaults
local keymapper = function(mode, lhs, rhs, override_opts, bufnr)
  -- set default options
  local opts = { noremap = true, silent = true }
  local buf_local = false

  -- if the user wants a buffer_local mapping, take note
  -- because we have to use nvim_buf_set_keymap instead
  if override_opts then
    if override_opts.buffer then
      -- remove buffer key from override_opts table
      override_opts.buffer = nil 
      buf_local = true
    end
    -- extend the default options with user's overrides
    vim.tbl_extend('keep', override_opts, opts)
  end

  -- set a buffer-local mapping
  if buf_local then
    vim.api.nvim_buf_set_keymap(bufnr or 0, mode, lhs, rhs, opts)
  -- set a regular global mapping
  else
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
  end
end

-- set a key mapping for normal mode
_G.nnoremap = function(lhs, rhs, opts, bufnr) keymapper('n', lhs, rhs, opts, bufnr) end
-- set a key mapping for insert mode
_G.inoremap = function(lhs, rhs, opts, bufnr) keymapper('i', lhs, rhs, opts, bufnr) end
-- set a key mapping for visual mode
_G.vnoremap = function(lhs, rhs, opts, bufnr) keymapper('v', lhs, rhs, opts, bufnr) end
-- set a key mapping for command-line mode
_G.cnoremap = function(lhs, rhs, opts, bufnr) keymapper('c', lhs, rhs, opts, bufnr) end
-- set a key mapping for terminal mode
_G.tnoremap = function(lhs, rhs, opts, bufnr) keymapper('t', lhs, rhs, opts, bufnr) end
-- set a key mapping for operator-pending mode
_G.onoremap = function(lhs, rhs, opts, bufnr) keymapper('o', lhs, rhs, opts, bufnr) end
-- set a key mapping for insert and command-line mode
_G.icnoremap = function(lhs, rhs, opts, bufnr) keymapper('!', lhs, rhs, opts, bufnr) end

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
