local ok, urlview = pcall(require, 'urlview')
if not ok then
  return
end

urlview.setup {
  title = 'URLs',
  default_picker = 'telescope',
  navigate_method = 'auto',
  debug = false,
  custom_searches = {},
}

local has_telescope, telescope = pcall(require, 'telescope')
if has_telescope then
  telescope.load_extension 'urlview'
end
