-- quickly print a lua table to :messages
_G.dump = function(...)
  vim.notify(vim.inspect(...), 'debug', { timeout = false })
end

-- wrapper for nvim_set_keymap with sensible defaults
local keymapper = function(mode, lhs, rhs, opts, bufnr)
  -- extend the default options with user's overrides
  local default_opts = { noremap = true, silent = true }
  opts = opts and vim.tbl_extend('keep', opts, default_opts) or default_opts

  -- set a buffer local mapping only if a buffer number is given to us
  if bufnr then
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
  else
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
  end
end

-- set a key mapping for normal mode
_G.nnoremap = function(lhs, rhs, opts, bufnr)
  keymapper('n', lhs, rhs, opts, bufnr)
end
-- set a key mapping for insert mode
_G.inoremap = function(lhs, rhs, opts, bufnr)
  keymapper('i', lhs, rhs, opts, bufnr)
end
-- set a key mapping for visual mode
_G.vnoremap = function(lhs, rhs, opts, bufnr)
  keymapper('v', lhs, rhs, opts, bufnr)
end
-- set a key mapping for command-line mode
_G.cnoremap = function(lhs, rhs, opts, bufnr)
  keymapper('c', lhs, rhs, opts, bufnr)
end
-- set a key mapping for terminal mode
_G.tnoremap = function(lhs, rhs, opts, bufnr)
  keymapper('t', lhs, rhs, opts, bufnr)
end
-- set a key mapping for operator-pending mode
_G.onoremap = function(lhs, rhs, opts, bufnr)
  keymapper('o', lhs, rhs, opts, bufnr)
end
-- set a key mapping for insert and command-line mode
_G.icnoremap = function(lhs, rhs, opts, bufnr)
  keymapper('!', lhs, rhs, opts, bufnr)
end

-- toggle two windows between vertical and horizontal splits
_G.rotate_windows = function()
  buffers_list = vim.api.nvim_exec('buffers', true)
  for match in buffers_list:gmatch '.*\n' do
    -- TODO: extract the buffer info 'a' for all active buffers and save it
    vim.notify(match, 'info')
  end
end
