return {
  'windwp/nvim-autopairs',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  event = 'InsertEnter',
  opts = {
    disable_filetype = {
      'TelescopePrompt',
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
  end,
}
