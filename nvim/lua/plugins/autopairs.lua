local npairs = require'nvim-autopairs'
local cmp_completion = require'nvim-autopairs.completion.cmp'

npairs.setup {
  disable_filetype = { "TelescopePrompt", "vim" },
  ignored_next_char = "[%w%.]",
}

-- you need setup cmp first put this after cmp.setup()
cmp_completion.setup {
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
  auto_select = false, -- automatically select the first item
  insert = false, -- use insert confirm behavior instead of replace
  map_char = { -- modifies the function or method delimiter by filetypes
    all = '(',
    tex = '{'
  }
}

-- load endwise plugin for lua files
npairs.add_rules(require'nvim-autopairs.rules.endwise-lua')
