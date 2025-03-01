return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  -- dependencies = 'rafamadriz/friendly-snippets',

  -- use a release tag to download pre-built binaries
  version = '*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- See the full "keymap" documentation for information on defining your own keymap.
    keymap = {
      preset = 'default',
      ['<C-e>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-y>'] = { 'hide' },
      ['<C-k>'] = { 'select_and_accept' },
      ['<Tab>'] = { 'select_and_accept', 'fallback' },

      ['<Up>'] = {},
      ['<Down>'] = {},
      ['<C-p>'] = { 'select_prev', 'fallback' },
      ['<C-n>'] = { 'select_next', 'fallback' },

      ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },

      ['<C-l>'] = { 'snippet_forward', 'fallback' },
      ['<C-h>'] = { 'snippet_backward', 'fallback' },

      ['<C-j>'] = { 'show_signature', 'hide_signature', 'fallback' },
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
      default = { 'lsp', 'snippets', 'path', 'buffer' },
      per_filetype = {
        markdown = { 'path', 'buffer' },
        lua = { 'lazydev', 'lsp', 'snippets', 'path', 'buffer' },
      },
      providers = {
        -- snippets = { score_offset = 100 },
        -- lsp = { score_offset = 90 },
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          -- score_offset = 90,
        },
      },
    },
  },
  opts_extend = { 'sources.default' },
}
