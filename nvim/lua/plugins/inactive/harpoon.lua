local has_harpoon, harpoon = pcall(require, 'harpoon')

if has_harpoon then
  harpoon.setup {
    menu = {
      width = 50,
      height = 8,
    },
  }

  nnoremap('<leader>jm', [[<cmd>lua require('harpoon.mark').add_file()<cr>]])
  nnoremap('<leader>je', [[<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>]])

  -- jump *file*
  nnoremap('<leader>ja', [[<cmd>lua require('harpoon.ui').nav_file(1)<cr>]])
  nnoremap('<leader>js', [[<cmd>lua require('harpoon.ui').nav_file(2)<cr>]])
  nnoremap('<leader>jd', [[<cmd>lua require('harpoon.ui').nav_file(3)<cr>]])
  nnoremap('<leader>jf', [[<cmd>lua require('harpoon.ui').nav_file(4)<cr>]])

  vim.cmd 'hi HarpoonWindow guifg=#ebbcba blend=nocombine'
  vim.cmd 'hi HarpoonBorder guifg=#eb6f92 blend=nocombine'
end
