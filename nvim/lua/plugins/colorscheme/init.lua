local ok, rose_pine = pcall(require, 'rose-pine')
if not ok then
  return
end

-- set my colorscheme to the correct variant depending on whether it's between 9am-5pm or not
local current_hour = tonumber(vim.fn.strftime '%H')
vim.g.color_mode = current_hour >= 9 and current_hour <= (12 + 5) and 'light' or 'dark'

rose_pine.setup {
  dark_variant = 'moon',
  light_variant = 'dawn',
}

require('maps').toggle_rose_pine_variant(vim.g.color_mode)
vim.cmd [[colorscheme rose-pine]]

local blend = require('rose-pine.util').blend
local highlight = require('rose-pine.util').highlight
local palette = require 'rose-pine.palette'

local diffs = {
  DiffAdd = { bg = blend('foam', palette.base, 0.15) },
  -- DiffChange = { bg = palette.surface },
  DiffChange = { bg = blend('rose', palette.base, 0.2) },
  DiffDelete = { bg = blend('love', palette.base, 0.15) },
  DiffText = { bg = blend('rose', palette.base, 0.2) },
  diffAdded = { link = 'DiffAdd' },
  diffChanged = { link = 'DiffChange' },
  diffRemoved = { link = 'DiffDelete' },
}

for diffGroup, color in pairs(diffs) do
  highlight(diffGroup, color)
end
