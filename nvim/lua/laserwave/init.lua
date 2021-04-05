local utils = require('laserwave.utils')
local color_defs = require('laserwave.definitions')

local highlight = vim.api.nvim_set_hl

--clear old highlights
utils.clear()

-- Color namespace
local ns = utils.set_namespace("laserwave")

-- Set highlights
for color_name, param in pairs(color_defs) do
  highlight(ns, color_name, param)
end
