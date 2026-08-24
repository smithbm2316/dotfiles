-- https://www.jvt.me/posts/2026/04/17/nvim-dap/
local ok, dap = pcall(require, 'dap')
if not ok then
  return
end

for _, adapterType in ipairs { 'node', 'chrome' } do
  local pwaType = 'pwa-' .. adapterType

  if not dap.adapters[pwaType] then
    dap.adapters[pwaType] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        command = 'node',
        args = {
          vim.env.XDG_DATA_HOME
            .. '/mise/installs/github-microsoft-vscode-js-debug/latest/src/dapDebugServer.js',
          '${port}',
        },
      },
    }
  end

  -- Define adapters without the "pwa-" prefix for VSCode compatibility
  if not dap.adapters[adapterType] then
    dap.adapters[adapterType] = function(cb, config)
      local nativeAdapter = dap.adapters[pwaType]

      config.type = pwaType

      if type(nativeAdapter) == 'function' then
        nativeAdapter(cb, config)
      else
        cb(nativeAdapter)
      end
    end
  end
end

local vscode = require 'dap.ext.vscode'
vscode.type_to_filetypes['node'] = _G.js_ts_fts
vscode.type_to_filetypes['pwa-node'] = _G.js_ts_fts

for _, language in ipairs(_G.js_ts_fts) do
  if not dap.configurations[language] then
    local runtimeExecutable = nil
    if language:find 'typescript' then
      runtimeExecutable = vim.fn.executable 'tsx' == 1 and 'tsx' or 'ts-node'
    end
    dap.configurations[language] = {
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        cwd = '${workspaceFolder}',
        sourceMaps = true,
        runtimeExecutable = runtimeExecutable,
        skipFiles = {
          '<node_internals>/**',
          'node_modules/**',
        },
        resolveSourceMapLocations = {
          '${workspaceFolder}/**',
          '!**/node_modules/**',
        },
      },
      {
        type = 'pwa-node',
        request = 'attach',
        name = 'Attach',
        processId = require('dap.utils').pick_process,
        cwd = '${workspaceFolder}',
        sourceMaps = true,
        runtimeExecutable = runtimeExecutable,
        skipFiles = {
          '<node_internals>/**',
          'node_modules/**',
        },
        resolveSourceMapLocations = {
          '${workspaceFolder}/**',
          '!**/node_modules/**',
        },
      },
    }
  end
end

---@class KeymapSetArgs
---@field modes string|string[]
---@field lhs string
---@field rhs string|function
---@field opts vim.keymap.set.Opts

--- @type KeymapSetArgs[]
local keymaps = {
  {
    modes = 'n',
    lhs = '<leader>ic',
    rhs = function()
      require('dap').continue()
    end,
    opts = { desc = 'dap: i[nspect] [c]ontinue' },
  },
  {
    modes = 'n',
    lhs = '<leader>isi',
    rhs = function()
      require('dap').step_into()
    end,
    opts = { desc = 'dap: i[nspect] [s]tep [i]nto' },
  },
  {
    modes = 'n',
    lhs = '<leader>iso',
    rhs = function()
      require('dap').step_over()
    end,
    opts = { desc = 'dap: i[nspect] [s]tep [o]ver' },
  },
  {
    modes = 'n',
    lhs = '<leader>isO',
    rhs = function()
      require('dap').step_out()
    end,
    opts = { desc = 'dap: i[nspect] [s]tep [o]ut' },
  },
  {
    modes = 'n',
    lhs = '<leader>isb',
    rhs = function()
      require('dap').step_back()
    end,
    opts = { desc = 'dap: i[nspect] [s]tep [b]ack' },
  },
  {
    modes = 'n',
    lhs = '<leader>itc',
    rhs = function()
      require('dap').run_to_cursor()
    end,
    opts = { desc = 'dap: i[nspect] run [t]o [c]ursor' },
  },
  {
    modes = 'n',
    lhs = '<leader>ibt',
    rhs = function()
      require('dap').toggle_breakpoint()
    end,
    opts = { desc = 'dap: i[nspect] [b]reakpoint [t]oggle' },
  },
  {
    modes = 'n',
    lhs = '<leader>ibs',
    rhs = function()
      require('dap').set_breakpoint()
    end,
    opts = { desc = 'dap: i[nspect] [b]reakpoint [s]et' },
  },
  {
    modes = 'n',
    lhs = '<leader>ibl',
    rhs = function()
      require('dap').list_breakpoints()
    end,
    opts = { desc = 'dap: i[nspect] [b]reakpoint [l]ist' },
  },
  {
    modes = 'n',
    lhs = '<leader>ibq',
    rhs = function()
      require('dap').clear_breakpoints()
    end,
    opts = { desc = 'dap: i[nspect] [b]reakpoint [c]lear' },
  },
  {
    modes = 'n',
    lhs = '<leader>il',
    rhs = function()
      dap.set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
    end,
    opts = { desc = 'dap: i[nspect] [l]og point' },
  },
  {
    modes = 'n',
    lhs = '<leader>it',
    rhs = function()
      require('dap').repl.toggle()
    end,
    opts = { desc = 'dap: i[nspect] [t]oggle repl' },
  },
  {
    modes = 'n',
    lhs = '<leader>ir',
    rhs = function()
      require('dap').run_last()
    end,
    opts = { desc = 'dap: i[nspect] [r]un last' },
  },
  {
    modes = 'n',
    lhs = '<leader>id',
    rhs = function()
      require('dap').terminate()
    end,
    opts = { desc = 'dap: i[nspect] [d]elete' },
  },
  {
    modes = { 'n', 'v' },
    lhs = '<leader>ih',
    rhs = function()
      require('dap.ui.widgets').hover()
    end,
    opts = { desc = 'dap: i[nspect] [h]over' },
  },
  {
    modes = { 'n', 'v' },
    lhs = '<leader>ip',
    rhs = function()
      require('dap.ui.widgets').preview()
    end,
    opts = { desc = 'dap: i[nspect] [p]review' },
  },
  {
    modes = 'n',
    lhs = '<leader>if',
    rhs = function()
      local widgets
      require 'dap.ui.widgets'
      widgets.centered_float(widgets.frames)
    end,
    opts = { desc = 'dap: i[nspect] [f]rames' },
  },
  {
    modes = 'n',
    lhs = '<leader>is',
    rhs = function()
      local widgets = require 'dap.ui.widgets'
      widgets.centered_float(widgets.scopes)
    end,
    opts = { desc = 'dap: i[nspect] [s]copes' },
  },
}

for _, keymap in ipairs(keymaps) do
  vim.keymap.set(keymap.modes, keymap.lhs, keymap.rhs, keymap.opts)
end
