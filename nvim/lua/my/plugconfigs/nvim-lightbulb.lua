require('nvim-lightbulb').update_lightbulb {
  sign = {
    enabled = false,
  },
  float = {
    enabled = false,
  },
  virtual_text = {
    enabled = true,
    text = "💡",
  },
}
vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
