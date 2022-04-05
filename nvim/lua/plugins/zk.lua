local has_zk, zk = pcall(require, 'zk')
if has_zk then
  zk.setup {
    picker = 'telescope',
    lsp = {
      config = {
        cmd = { 'zk', 'lsp', '--log', '/tmp/zk-lsp.log' },
        name = 'zk',
        on_attach = function(client, bufnr)
          require('plugins.lsp').my_on_attach(client, bufnr)
          vnoremap('<leader>nn', [[:'<,'>lua vim.lsp.buf.range_code_action()<cr>]], nil, { buffer = bufnr })
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
  -- create a new note
  nnoremap('<leader>nn', function()
    vim.ui.input({ prompt = 'Title: ' }, function(input)
      if input then
        zk.new {
          title = input,
        }
      end
    end)
  end)
end
