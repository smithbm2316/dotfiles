local npairs = require 'nvim-autopairs'

npairs.setup {
  disable_filetype = { 'TelescopePrompt', 'vim' },
  ignored_next_char = '[%w%.]',
}
-- If you want insert `(` after select function or method item
local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
local cmp = require 'cmp'
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done {
    map_char = { tex = '' },
  }
)

-- load endwise plugin for lua files
npairs.add_rules(require 'nvim-autopairs.rules.endwise-lua')
