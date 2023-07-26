local ok, focus = pcall(require, 'focus')
if not ok then
  return
end

-- local golden_ratio = 1.618
local golden_ratio = 1.5

local golden_ratio_width = function()
  local maxwidth = vim.o.columns
  return maxwidth > 160 and math.floor(maxwidth / golden_ratio) or 120
end

--[[ local golden_ratio_minwidth = function()
  return math.floor(golden_ratio_width() / (3 * golden_ratio))
end ]]

focus.setup {
  excluded_filetypes = { 'TelescopePrompt', 'help', 'harpoon', 'DiffviewFiles' },
  excluded_buftypes = { 'nofile' },
  ui = {
    signcolumn = false,
  },
  width = golden_ratio_width(),
}

nnoremap('<leader>fi', function()
  focus.focus_toggle()
end, 'Toggle Focus.nvim')
