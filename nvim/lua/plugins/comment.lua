local comment = {}

-- load Comment.nvim modules
-- local ft = require 'Comment.ft'
local U = require 'Comment.utils'
local E = require 'Comment.extra'

-- set default config table for Comment
local config = {
  padding = true,
  ignore = nil,
  mappings = {
    basic = true,
    extra = false,
    extended = false,
  },
  toggler = {
    line = 'cml',
    block = 'cmb',
  },
  opleader = {
    line = 'cm',
    block = 'cb',
  },
  pre_hook = function(_) -- ctx
    -- call ts-context-commenstring to update what the comment should be at the
    -- moment (particularly useful in JSX where you have lots of comment types
    -- depending on file location)
    if vim.bo.filetype ~= 'lua' then
      return require('ts_context_commentstring.internal').calculate_commentstring()
    end
  end,
  post_hook = nil,
}

-- and load the plugin
require('Comment').setup(config)

-- define wrapper function to map the extra Comment.nvim mappings to
comment.extra = function(key)
  if key == 'o' then
    -- This powers the `gco`
    E.norm_o(U.ctype.line, config) -- With linewise
  elseif key == 'O' then
    -- This powers the `gcO`
    E.norm_O(U.ctype.line, config) -- With linewise
  elseif key == 'A' then
    -- This powers the `gcA`
    E.norm_A(U.ctype.line, config) -- With linewise
  end
end

-- set custom extra mappings
nnoremap('cmo', [[<cmd>lua require('plugins.comment').extra('o')<cr>]])
nnoremap('cmO', [[<cmd>lua require('plugins.comment').extra('O')<cr>]])
nnoremap('cmA', [[<cmd>lua require('plugins.comment').extra('A')<cr>]])

return comment
