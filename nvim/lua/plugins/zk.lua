require('zk').setup {
  picker = 'telescope',
  lsp = {
    config = {
      cmd = { 'zk', 'lsp', '--log', '/tmp/zk-lsp.log' },
      name = 'zk',
      on_attach = function(client, bufnr)
        require('plugins.lsp').my_on_attach(client, bufnr)

        nnoremap('<leader>zi', [[:ZkIndex<cr>]], nil, bufnr)
        vnoremap('<leader>zn', [[:'<,'>lua vim.lsp.buf.range_code_action()<cr>]], nil, bufnr)
        nnoremap('<leader>zn', [[:ZkNew {title = vim.fn.input('Title: ')}<cr>]], nil, bufnr)
        nnoremap('<leader>zl', [[:ZkNew {dir = 'log'}<cr>]], nil, bufnr)
      end,
      capabilities = require('plugins.lsp').my_capabilities,
    },
    auto_attach = {
      enabled = true,
      filetypes = { 'markdown' },
    },
  },
  -- commands = {},
}
