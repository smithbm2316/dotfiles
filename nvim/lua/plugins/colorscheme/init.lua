local has_rose_pine, rose_pine = pcall(require, 'rose-pine')
if has_rose_pine then
  local color_mode = 'dark'

  rose_pine.setup {
    dark_variant = 'moon',
    light_variant = 'dawn',
  }

  require('maps').toggle_rose_pine_variant(color_mode)
  vim.cmd 'colorscheme rose-pine'

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
end
