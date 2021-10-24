local ft = require('Comment.ft')

require'Comment'.setup {
  padding = true,
  ignore = nil,
  mappings = {
    basic = true,
    extra = true,
    extended = false,
  },
  toggler = {
    line = 'gcc',
    block = 'gbc',
  },
  opleader = {
    line = 'gc',
    block = 'gb',
  },
  pre_hook = function(ctx)
    if vim.bo.filetype ~= 'lua' then
      return require('ts_context_commentstring.internal').calculate_commentstring()
    end
  end,
  post_hook = nil,
}
