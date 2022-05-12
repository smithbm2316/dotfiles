local ok, zk = pcall(require, 'zk')
if not ok then
  return
end

zk.setup {
  picker = 'telescope',
  lsp = {
    config = {
      cmd = { 'zk', 'lsp', '--log', '/tmp/zk-lsp.log' },
      name = 'zk',
      on_attach = function(client, bufnr)
        -- pass bufnr to the keymaps table overrides
        local buf = { buffer = bufnr }

        -- load lsp on_attach
        require('plugins.lsp').my_on_attach(client, bufnr)

        -- create a new note with tags
        nnoremap('<leader>nn', function()
          vim.ui.input({ prompt = 'Title: ' }, function(title)
            if title then
              -- only create a new note if a title is supplied
              vim.ui.input({ prompt = 'Tags: ' }, function(tags)
                if tags then
                  -- if we have tags, parse them and insert them to the end of the file
                  local content = '\n'
                  for tag in tags:gmatch '%w+' do
                    content = string.format('%s#%s ', content, tag)
                  end
                  zk.new {
                    title = title,
                    content = string.sub(content, 1, -2),
                  }
                else
                  -- otherwise just create a new note with the entered-in title
                  zk.new {
                    title = title,
                  }
                end
              end)
            end
          end)
        end, 'New zk note')

        -- code action in visual mode
        vnoremap('<leader>nn', [[:'<,'>lua vim.lsp.buf.range_code_action()<cr>]], 'Zk code action', buf)

        -- send a query to the Zk database for full-text search
        nnoremap('<leader>nq', function()
          vim.ui.input({ prompt = 'Query your notebook: ' }, function(input)
            if input then
              zk.pick_notes({ match = input }, { title = string.format('Matches for query %q', input) })
            end
          end)
        end, 'Zk notes query', buf)
      end,
      capabilities = require('plugins.lsp').my_capabilities,
    },
    auto_attach = {
      enabled = true,
      filetypes = { 'markdown' },
    },
  },
}
