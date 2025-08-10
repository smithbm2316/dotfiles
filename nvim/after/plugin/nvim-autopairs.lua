require('nvim-autopairs').setup {
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
}

-- disable quote pairs in lisp and vimscript
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lisp', 'vim' },
  group = vim.api.nvim_create_augroup('NvimAutopairs', { clear = true }),
  callback = function()
    require('nvim-autopairs').remove_rule [["]]
  end,
})
