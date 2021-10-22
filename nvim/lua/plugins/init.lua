-- runtime path to current file
local plugin_config_root = 'plugins.'
local plugin_configs = vim.fn.globpath('lua/plugins', '*')
local discard, core_plugin_configs, plugin_config_files = {}, {}, {}

for match in plugin_configs:gmatch('([%w%d-_.]+)%c') do
  if match == 'inactive' or match == 'opt' or match == 'init.lua' then
    table.insert(discard, match)
  elseif match:sub(-4, -1) == '.lua' then
    table.insert(plugin_config_files, match:sub(0, -5))
  else
    table.insert(core_plugin_configs, match)
  end
end

-- load and setup core plugins before all others
for _, plugin in ipairs(core_plugin_configs) do
  require(plugin_config_root .. plugin)
end

-- load plugin config files
for _, plugin in ipairs(plugin_config_files) do
  require(plugin_config_root .. plugin)
end
