local config = require('kommentary.config')

config.configure_language('default', {
  use_consistent_indentation = true,
  ignore_whitespace = true,
  hook_function = function()
    require('ts_context_commentstring.internal').update_commentstring()
  end,
})

local singleline = { 'lua' }
config.configure_language(singleline, {
  prefer_single_line_comments = true,
})

-- local multiline = {}
-- config.configure_language(multiline, {
--   prefer_multi_line_comments = true,
-- })
