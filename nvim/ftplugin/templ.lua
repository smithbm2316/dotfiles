-- Format current buffer using LSP.
vim.api.nvim_create_autocmd({
  -- 'BufWritePre' event triggers just before a buffer is written to file.
  'BufWritePre',
}, {
  pattern = { '*.templ' },
  callback = function()
    -- Format the current buffer using Neovim's built-in LSP (Language Server Protocol).
    vim.lsp.buf.format()
  end,
})
