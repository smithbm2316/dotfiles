local ok, bqf = pcall(require, 'bqf')
if not ok then
  return
end

bqf.setup {
  auto_enable = true,
  auto_resize_height = true, -- highly recommended enable
  --[[ func_map = {
    filter = 'zn',
    filterr = 'zN',
  }, ]]
}

nnoremap('zn', function()
  require('bqf.filter.base').run(false)
end)

nnoremap('zN', function()
  require('bqf.filter.base').run(true)
end)
