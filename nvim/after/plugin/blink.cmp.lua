local ok, blink = pcall(require, 'blink.cmp')
if not ok then
  return
end

blink.setup {
  -- 'default' for mappings similar to built-in completion
  -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
  -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
  -- See the full "keymap" documentation for information on defining your own keymap.
  keymap = {
    preset = 'default',
    ['<c-y>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<c-e>'] = { 'hide' },
    ['<c-k>'] = { 'select_and_accept' },
    ['<tab>'] = nil,
    ['<c-j>'] = nil,

    ['<up>'] = nil,
    ['<down>'] = nil,
    ['<c-p>'] = { 'select_prev', 'fallback' },
    ['<c-n>'] = { 'select_next', 'fallback' },

    ['<c-u>'] = { 'scroll_documentation_up', 'fallback' },
    ['<c-d>'] = { 'scroll_documentation_down', 'fallback' },

    ['<c-l>'] = { 'snippet_forward', 'fallback' },
    ['<c-h>'] = { 'snippet_backward', 'fallback' },

    -- ['<c-j>'] = { 'show_signature', 'hide_signature', 'fallback' },
  },

  completion = {
    accept = {
      auto_brackets = { enabled = true },
    },
    documentation = {
      auto_show = true,
      treesitter_highlighting = true,
    },
    ghost_text = { enabled = false },
  },

  -- Experimental signature help support
  signature = {
    enabled = true,
    trigger = {
      -- Show the signature help automatically
      enabled = true,
      -- Show the signature help window after typing any of alphanumerics, `-` or `_`
      show_on_keyword = false,
      blocked_trigger_characters = {},
      blocked_retrigger_characters = {},
      -- Show the signature help window after typing a trigger character
      show_on_trigger_character = true,
      -- Show the signature help window when entering insert mode
      show_on_insert = true,
      -- Show the signature help window when the cursor comes after a trigger character when entering insert mode
      show_on_insert_on_trigger_character = true,
    },
  },

  -- Default list of enabled providers defined so that you can extend it
  -- elsewhere in your config, without redefining it, due to `opts_extend`
  sources = {
    default = {
      'lsp',
      'path',
      'snippets',
      'buffer',
    },
    per_filetype = {
      markdown = { 'path' },
    },
    -- providers = {
    --   snippets = { score_offset = 100 },
    --   lsp = { score_offset = 90 },
    -- },
  },

  snippets = { preset = 'mini_snippets' },
}
