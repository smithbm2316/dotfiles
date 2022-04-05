-------------------------------
-------------------------------
----- Print table wrapper -----
-------------------------------
-------------------------------
-- quickly print a lua table to :messages
_G.dump = function(obj, use_notify)
  if use_notify then
    vim.notify(vim.inspect(obj), 'debug', { timeout = false })
  else
    print(vim.inspect(obj))
  end
  return obj
end

-------------------------------
-------------------------------
----- Keymapping wrappers -----
-------------------------------
-------------------------------
-- wrapper for nvim_set_keymap with sensible defaults
-- TODO: swap the location of the `opts` and `label` params since i rarely pass `opts`
_G.noremap = function(modes, lhs, rhs, label, opts)
  -- check if this is a <leader> mapping. If so, register it with which-key
  local uses_leader = lhs:match '<leader>.*'

  if uses_leader then
    local ok, wk = pcall(require, 'which-key')
    if ok then
      -- extract the last keystroke of the mapping
      local last_keystroke = lhs:sub(-1)
      -- make an iterable table of all the modes for this keymap
      modes = type(modes) == 'string' and { modes } or modes
      for _, mode in ipairs(modes) do
        -- if we don't supply a label, remind me that i need to add one and avoid an error
        if not label then
          if type(rhs) == 'string' then
            label = rhs:gsub('<cmd>lua ', ''):gsub('<cr>', '')
          else
            label = 'needs label'
          end
        end
        wk.register({
          [last_keystroke] = { rhs, label },
        }, {
          mode = mode,
          prefix = lhs:sub(1, -2), -- extract all but the last keystroke of the mapping
          silent = true,
          noremap = true,
          buffer = opts and opts.buffer or nil,
        })
      end
      return
    end
  end
  -- if we didn't have a <leader> mapping or which key is unavailable, default
  -- to built-in lua function vim.keymap.set()

  -- extend the default options with user's overrides
  local default_opts = { noremap = true, silent = true }
  opts = opts and vim.tbl_extend('keep', opts, default_opts) or default_opts

  vim.keymap.set(modes, lhs, rhs, opts)
end

-- set a key mapping for normal mode
_G.nnoremap = function(lhs, rhs, label, opts)
  noremap('n', lhs, rhs, label, opts)
end
-- set a key mapping for insert mode
_G.inoremap = function(lhs, rhs, label, opts)
  noremap('i', lhs, rhs, label, opts)
end
-- set a key mapping for visual mode
_G.vnoremap = function(lhs, rhs, label, opts)
  noremap('v', lhs, rhs, label, opts)
end
-- set a key mapping for command-line mode
_G.cnoremap = function(lhs, rhs, label, opts)
  noremap('c', lhs, rhs, label, opts)
end
-- set a key mapping for terminal mode
_G.tnoremap = function(lhs, rhs, label, opts)
  noremap('t', lhs, rhs, label, opts)
end
-- set a key mapping for operator-pending mode
_G.onoremap = function(lhs, rhs, label, opts)
  noremap('o', lhs, rhs, label, opts)
end
-- set a key mapping for insert and command-line mode
_G.icnoremap = function(lhs, rhs, label, opts)
  noremap('!', lhs, rhs, label, opts)
end

---------------------------------
---------------------------------
----- Rotate windows helper -----
---------------------------------
---------------------------------
-- toggle two windows between vertical and horizontal splits
_G.rotate_windows = function()
  buffers_list = vim.api.nvim_exec('buffers', true)
  for match in buffers_list:gmatch '.*\n' do
    -- TODO: extract the buffer info 'a' for all active buffers and save it
    vim.notify(match, 'info')
  end
end

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

-- helper function to toggle an augroup on/off
_G.BS_toggle_augroup = function(group)
  if _G.BSAugroups[group].enabled then
    _G.BSAugroups[group].enabled = false
    vim.api.nvim_del_augroup_by_name(group)
    vim.notify('Disabled ' .. group)
  else
    _G.BSAugroups[group].enabled = true
    create_aucmds(group, _G.BSAugroups[group].aucmds)
    vim.notify('Enabled ' .. group)
  end
end
