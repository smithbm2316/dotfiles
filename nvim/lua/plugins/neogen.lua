local ok, neogen = pcall(require, 'neogen')
if not ok then
  return
end

neogen.setup {
  enabled = true,
  input_after_comment = true,
  snippet_engine = 'luasnip',
  languages = {
    lua = {
      template = {
        annotation_convention = 'emmylua',
      },
    },
    typescript = {
      template = {
        annotation_convention = 'tsdoc',
      },
    },
    typescriptreact = {
      template = {
        annotation_convention = 'tsdoc',
      },
    },
  },
}

nnoremap('<leader>ia', function()
  neogen.generate()
end, 'Insert annotation')
