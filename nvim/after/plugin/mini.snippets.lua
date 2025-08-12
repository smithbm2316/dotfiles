local gen_loader = require('mini.snippets').gen_loader

local js_lang_patterns = { 'js.lua' }

local from_lang_loader = gen_loader.from_lang {
  lang_patterns = {
    javascript = js_lang_patterns,
    javascriptreact = js_lang_patterns,
    jsx = js_lang_patterns,
    tsx = js_lang_patterns,
    typescript = js_lang_patterns,
    typescriptreact = js_lang_patterns,
  },
}

require('mini.snippets').setup {
  mappings = {
    -- Expand snippet at cursor position. Created globally in Insert mode.
    expand = '<c-j>',
    -- Interact with default `expand.insert` session.
    -- Created for the duration of active session(s)
    jump_next = '<c-l>',
    jump_prev = '<c-h>',
    stop = '<c-c>',
  },

  snippets = {
    gen_loader.from_file(vim.env.XDG_CONFIG_HOME .. '/nvim/snippets/all.json'),
    from_lang_loader,
  },
}
