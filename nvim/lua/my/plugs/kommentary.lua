local config = require('kommentary.config')

local update_commentstring = function()
  require('ts_context_commentstring.internal').update_commentstring()
end

config.configure_language('default', {
  use_consistent_indentation = true,
  ignore_whitespace = true,
  hook_function = update_commentstring,
})

local singleline = { 'lua' }
config.configure_language(singleline, {
  prefer_single_line_comments = true,
})

local webdev = {
  'javascript',
  'javascriptreact',
  'typescript',
  'typescriptreact'
}
config.configure_language(webdev, {
  hook_function = update_commentstring,
})

-- local multiline = {}
-- config.configure_language(multiline, {
--   prefer_multi_line_comments = true,
-- })
