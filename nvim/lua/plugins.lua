---@alias PluginConfig string|[string, string, string|nil]

---@type PluginConfig[]
local plugins = {
  'catppuccin/nvim',
  'christoomey/vim-sort-motion',
  'christoomey/vim-system-copy',
  'christoomey/vim-tmux-navigator',
  { 'echasnovski/mini.bufremove', 'stable' },
  { 'echasnovski/mini.completion', 'stable' },
  { 'echasnovski/mini.extra', 'stable' },
  { 'echasnovski/mini.icons', 'stable' },
  { 'echasnovski/mini.notify', 'stable' },
  { 'echasnovski/mini.pairs', 'stable' },
  { 'echasnovski/mini.pick', 'stable' },
  { 'echasnovski/mini.sessions', 'stable' },
  { 'echasnovski/mini.statusline', 'stable' },
  { 'echasnovski/mini.snippets', 'stable' },
  'laytan/cloak.nvim',
  'lewis6991/gitsigns.nvim', -- mini.diff, mini.git
  'mfussenegger/nvim-lint',
  'nvim-treesitter/nvim-treesitter',
  'stevearc/conform.nvim',
  'stevearc/oil.nvim',
  'tpope/vim-repeat',
  'tpope/vim-surround',
  'vim-scripts/ReplaceWithRegister',
  'watzon/vim-edge-template',
  'markgarrigan/edge.nvim',

  -- to vendor:
  -- 01. steschwa/css-tools.nvim
  -- 02. Jezda1337/nvim-html-css

  -- to add:
  -- { 'echasnovski/mini.ai',  'stable' },
  -- { 'echasnovski/mini.align', 'stable' },
  -- { 'echasnovski/mini.comment', 'stable' },
  -- { 'echasnovski/mini.fuzzy', 'stable' },
  -- { 'echasnovski/mini.indentscope', 'stable' },
  -- { 'echasnovski/mini.operators', 'stable' },
  -- { 'echasnovski/mini.splitjoin', 'stable' },
}

---converts a PluginConfig input into a vim.pack.Spec-compliant table with some
---sane defaults and overrides implemented.
---@param plug PluginConfig
---@return vim.pack.SpecResolved
local plugin_info_to_spec = function(plug)
  vim.validate(
    'plug',
    plug,
    { 'string', 'table' },
    false,
    'Each plugin config should be a string or PluginConfig table.'
  )
  plug = type(plug) == 'table' and plug or { plug }

  -- required fields
  vim.validate('plug[1]', plug[1], function(name)
    return type(name) == 'string' and string.match(name, '^[^/]*/[^/]*$')
  end)
  ---@type string
  local name = plug[1]

  -- optional fields
  vim.validate('plug[2]', plug[2], function(version)
    return type(version) == 'string' or version == nil
  end)
  ---@type string|nil
  local version = plug[2]

  vim.validate('plug[3]', plug[3], function(git_url_prefix)
    if type(git_url_prefix) == 'string' and git_url_prefix ~= '' then
      return true
    elseif git_url_prefix == nil then
      return true
    else
      return false
    end
  end)
  ---@type string
  local git_url_prefix = plug[3] ~= nil and plug[3] or 'https://github.com/'

  return {
    src = git_url_prefix .. name,
    version = version,
    name = name,
  }
end

vim.pack.add(vim.tbl_map(plugin_info_to_spec, plugins))

vim.keymap.set('n', '<leader>pU', vim.pack.update, {
  desc = '[p]ack [u]pdate',
})

vim.keymap.set('n', '<leader>pC', function()
  ---@type string[]
  local inactive_plugins = {}
  for _, plugin in ipairs(vim.pack.get()) do
    if not plugin.active then
      table.insert(inactive_plugins, plugin.spec.name)
    end
  end
  if #inactive_plugins == 0 then
    vim.notify 'No plugins to clean.'
    return
  end

  local plugins_to_delete = vim.iter(inactive_plugins):join ', '
  vim.ui.input({
    prompt = string.format(
      'Do you want to delete the following plugins: %s (y/n): ',
      plugins_to_delete
    ),
  }, function(input)
    if type(input) == 'string' and input:lower():sub(0, 1) == 'y' then
      vim.notify('Deleting plugins: ' .. plugins_to_delete)
      vim.pack.del(inactive_plugins)
      vim.notify 'Done.'
    else
      vim.notify 'Cancelling deletion, no plugins will be affected.'
    end
  end)
end, {
  desc = '[p]ack [c]lean inactive plugins',
})
