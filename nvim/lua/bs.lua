-- TODO: WIP fix this and move away from direct global funcs
local bs = {}

-- quickly print a lua table to :messages
bs.dump = function(...)
  print(vim.inspect(...))
end

-- wrapper for nvim_set_keymap with sensible defaults
bs.keymapper = function(mode, lhs, rhs, override_opts, bufnr)
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

-- create functions for all of the different map modes
local modes = {
  'n',
  'i',
  'v',
  'c',
  't',
  'o',
  'ic',
}
for _, map_mode in ipairs(modes) do
  bs[map_mode .. 'noremap'] = function(mode, lhs, rhs, opts, bufnr)
    bs.keymapper(mode, lhs, rhs, opts, bufnr)
  end
end

-- toggle two windows between vertical and horizontal splits
bs.rotate_windows = function()
  buffers_list = nv.exec('buffers', true)
  for match in buffers_list:gmatch '.*\n' do
    -- TODO: extract the buffer info 'a' for all active buffers and save it
    print(match)
  end
end

return bs
