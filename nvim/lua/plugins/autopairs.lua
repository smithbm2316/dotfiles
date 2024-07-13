return {
  'windwp/nvim-autopairs',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  event = 'InsertEnter',
  opts = {
    disable_filetype = {
      'TelescopePrompt',
      -- 'markdown'
    },
    ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], '%s+', ''),
    pairs_map = {
      ["'"] = "'",
      ['"'] = '"',
      ['('] = ')',
      ['['] = ']',
      ['{'] = '}',
      ['`'] = '`',
    },
  },
  config = function(_, opts)
    require('nvim-autopairs').setup(opts)

    -- disable quote pairs in lisp and vimscript
    vim.api.nvim_create_augroup('AutopairsFiletypeCmds', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'lisp', 'vim' },
      group = 'AutopairsFiletypeCmds',
      callback = function()
        require('nvim-autopairs').remove_rule [["]]
      end,
    })

    -- If you want insert `(` after select function or method item
    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    local cmp = require 'cmp'
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done {
        map_char = { tex = '' },
      }
    )
  end,
}
