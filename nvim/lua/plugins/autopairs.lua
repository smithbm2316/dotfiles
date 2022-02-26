local npairs = require 'nvim-autopairs'
local Rule = require 'nvim-autopairs.rule'
local cond = require 'nvim-autopairs.conds'

npairs.setup {
  disable_filetype = { 'TelescopePrompt', 'markdown' },
  ignored_next_char = '[%w%.]',
  pairs_map = {
    ["'"] = "'",
    ['"'] = '"',
    ['('] = ')',
    ['['] = ']',
    ['{'] = '}',
    ['`'] = '`',
  },
}

-- disable quote pairs in lisp and vimscript
vim.cmd [[
  augroup AutopairsFiletypeCmds
    au!
    au FileType lisp lua require'nvim-autopairs'.remove_rule("'")
    au FileType vim lua require'nvim-autopairs'.remove_rule('"')
  augroup END
]]

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
-- npairs.add_rules(require 'nvim-autopairs.rules.endwise-lua')
