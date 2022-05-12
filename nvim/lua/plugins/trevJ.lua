local ok, trevj = pcall(require, 'trevj')
if not ok then
  return
end

trevj.setup {}

nnoremap('gJ', function()
  trevj.format_at_cursor()
end, 'Reverse J')
