local disabled_plugins = {
  '2html_plugin',
  'getscript',
  'getscriptPlugin',
  'gzip',
  'logiPat',
  -- 'man',
  -- 'matchit',
  -- 'matchparen',
  'netrw',
  'netrwFileHandlers',
  'netrwPlugin',
  'netrwSettings',
  'remote_plugins',
  'rplugin',
  'rrhelper',
  'shada',
  'shada_plugin',
  'spec',
  -- 'spellfile',
  -- 'spellfile_plugin',
  'tar',
  'tarPlugin',
  'tohtml',
  'tutor',
  'tutor_mode_plugin',
  'vimball',
  'vimballPlugin',
  'zip',
  'zipPlugin',
}

-- disable highlighting pairs for matchup
vim.g.matchup_matchparen_enabled = 0

-- disable remote plugin providers
vim.g.loaded_node_provider = 1
vim.g.loaded_perl_provider = 1
vim.g.loaded_python3_provider = 1
vim.g.loaded_python_provider = 1
vim.g.loaded_pythonx_provider = 1
vim.g.loaded_ruby_provider = 1

for _, plugin in ipairs(disabled_plugins) do
  vim.g['loaded_' .. plugin] = 1
end

return disabled_plugins
