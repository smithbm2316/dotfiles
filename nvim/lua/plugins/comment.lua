local comment = {}

-- load Comment.nvim modules
local ft = require 'Comment.ft'
local utils = require 'Comment.utils'
local extra = require 'Comment.extra'

-- set default config table for Comment
local config = {
  padding = true,
  ignore = nil,
  mappings = {
    basic = true,
    extra = false,
  },
  toggler = {
    line = 'cml',
    block = 'cmb',
  },
  opleader = {
    line = 'cl',
    block = 'cm',
  },
  --[[ pre_hook = function(ctx)
    -- call ts-context-commentstring to update what the comment should be at the
    -- moment (particularly useful in JSX where you have lots of comment types
    -- depending on file location)
    local location = nil
    if ctx.ctype == comment_utils.ctype.block then
      location = require('ts_context_commentstring.utils').get_cursor_location()
    elseif ctx.cmotion == comment_utils.cmotion.v or ctx.cmotion == comment_utils.cmotion.V then
      location = require('ts_context_commentstring.utils').get_visual_start_location()
    end

    return require('ts_context_commentstring.internal').calculate_commentstring {
      key = ctx.ctype == comment_utils.ctype.line and '__default' or '__multiline',
      location = location,
    }
  end, ]]
  post_hook = nil,
}

-- and load the plugin
require('Comment').setup(config)

-- use server-removed comments (three dashes) for webc
ft.webc = { '<!--- %s --->', '<!--- %s --->' }

ft.templ = {
  -- setup line comments as Go comments
  '// %s',
  -- and block comments as HTML comments
  '<!-- %s -->',
}

-- define wrapper function to map the extra Comment.nvim mappings to
comment.extra = function(key)
  if key == 'o' then
    -- This powers the `gco`
    extra.norm_o(utils.ctype.line, config) -- With linewise
  elseif key == 'O' then
    -- This powers the `gcO`
    extra.norm_O(utils.ctype.line, config) -- With linewise
  elseif key == 'A' then
    -- This powers the `gcA`
    extra.norm_A(utils.ctype.line, config) -- With linewise
  end
end

-- set custom extra mappings
nnoremap('cmo', [[<lua require('plugins.comment').extra('o')<cr>]])
nnoremap('cmO', [[<cmd>lua require('plugins.comment').extra('O')<cr>]])
nnoremap('cmA', [[<cmd>lua require('plugins.comment').extra('A')<cr>]])

return comment
