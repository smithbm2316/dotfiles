-- set the default commentstring to a hashtag and update the blockwise map to
-- use linewise mapping instead since there's no blockwise comment for the
-- `dosini` filetype
vim.bo.commentstring = '#%s'
vnoremap(
  'cm',
  [[<Esc><Cmd>lua require("Comment.api").locked.toggle_linewise_op(vim.fn.visualmode())<CR>]],
  nil,
  { buffer = 0 }
)
