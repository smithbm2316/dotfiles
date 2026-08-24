vim.opt_local.textwidth = 0
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.tabstop = 2
vim.opt_local.wrap = true

for _, mode in ipairs { 'n', 'v', 'o' } do
  for _, movement in ipairs { 'j', 'k', '0', '^', '$' } do
    vim.keymap.set(mode, movement, function()
      if vim.opt_local.wrap:get() then
        return 'g' .. movement
      else
        return movement
      end
    end, { buffer = true, expr = true, silent = true, remap = false })

    vim.keymap.set(mode, 'g' .. movement, function()
      if vim.opt_local.wrap:get() then
        return movement
      else
        return 'g' .. movement
      end
    end, { buffer = true, expr = true, silent = true, remap = false })
  end
end
