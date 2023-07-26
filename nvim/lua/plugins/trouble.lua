local ok, trouble = pcall(require, 'trouble')
if not ok then
  return
end
trouble.setup {}

vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
  desc = "Automatically intercepts any commands opening the quickfix list and opens it with Trouble.nvim's quickfix list wrapper instead",
  pattern = { 'quickfix' },
  callback = function()
    vim.defer_fn(function()
      vim.cmd 'cclose'
      trouble.open 'quickfix'
    end, 0)
  end,
})
