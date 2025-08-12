---@alias PluginConfig string|[string, string, string|nil]

---@type PluginConfig[]
local plugins = {
  'catgoose/nvim-colorizer.lua',
  'catppuccin/nvim',
  'christoomey/vim-sort-motion',
  'christoomey/vim-system-copy',
  'christoomey/vim-tmux-navigator',
  -- { 'echasnovski/mini.nvim', 'stable' },
  { 'echasnovski/mini.bufremove', 'stable' },
  { 'echasnovski/mini.completion', 'stable' },
  { 'echasnovski/mini.icons', 'stable' },
  { 'echasnovski/mini.pick', 'stable' },
  { 'echasnovski/mini.sessions', version = 'stable' },
  -- to add:
  -- { 'echasnovski/mini.ai', version = 'stable' },
  -- { 'echasnovski/mini.comment', version = 'stable' },
  -- { 'echasnovski/mini.fuzzy', version = 'stable' },
  -- { 'echasnovski/mini.indentscope', version = 'stable' },
  -- { 'echasnovski/mini.operators', version = 'stable' },
  -- { 'echasnovski/mini.splitjoin', version = 'stable' },
  'laytan/cloak.nvim',
  'lewis6991/gitsigns.nvim', -- mini.diff, mini.git
  'mfussenegger/nvim-lint',
  'nvim-treesitter/nvim-treesitter',
  'stevearc/conform.nvim',
  'stevearc/oil.nvim',
  'tpope/vim-repeat',
  'tpope/vim-surround', -- mini.surround
  'vim-scripts/ReplaceWithRegister',
  'windwp/nvim-autopairs', -- mini.pairs
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

-- NICE TO HAVE
-- 01. Jezda1337/nvim-html-css
-- 02. JoosepAlviste/nvim-ts-context-commentstring
-- 03. lukas-reineke/indent-blankline.nvim (mini.indentscope)
-- 04. nvim-treesitter/nvim-treesitter-textobjects (mini.ai)
-- 05. stevearc/dressing.nvim
-- 06. windwp/nvim-ts-autotag

-- VENDOR
-- 01. neovim/nvim-lspconfig
-- 02. steschwa/css-tools.nvim

-- REPLACE
-- 01. rmagatti/auto-session
-- 02. nvim-focus/focus.nvim
-- 03. nvim-telescope/telescope.nvim (mini.pick)
-- 04. nvim-telescope/telescope-fzf-native.nvim (mini.fuzzy)
-- 05. nvim-tree/nvim-web-devicons (mini.icons)

-- REMOVE
-- 01. amadeus/vim-convert-color-to
-- 02. arthurxavierx/vim-caser
-- 03. cameron-wags/rainbow_csv.nvim
-- 04. danymat/neogen
-- 05. folke/todo-comments.nvim
-- 06. folke/trouble.nvim
-- 07. folke/which-key.nvim
-- 08. junegunn/vim-slash
-- 09. nvim-lua/plenary.nvim
-- 10. nvim-lualine/lualine.nvim
-- 11. nvim-treesitter/playground
-- 12. saghen/blink.cmp
-- 13. tpope/vim-dadbod
-- 14. zenbones-theme/zenbones.nvim

-- REMOVE, BUT KEEP CONFIG FOR THESE
-- 01. folke/lazydev.nvim
-- 02. milisims/nvim-luaref
-- 03. nanotee/luv-vimdocs
-- 04. nanotee/nvim-lua-guide
