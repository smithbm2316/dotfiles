---@type vim.lsp.Config
return {
  cmd = { 'oxfmt', '--lsp' },
  filetypes = {
    'graphql',
    'javascript',
    'javascriptreact',
    'json',
    'json5',
    'jsonc',
    'typescript',
    'typescriptreact',
  },
  root_markers = {
    '.oxfmtrc.json',
    '.oxfmtrc.jsonc',
    'oxfmt.config.ts',
    '.git',
  },
  on_attach = function(client, bufnr)
    local local_cmd =
      vim.fs.joinpath(vim.fn.getcwd(0), 'node_modules/.bin', 'oxfmt')
    if vim.fn.executable(local_cmd) == 1 then
      client.config.cmd = { local_cmd, '--lsp' }
      local status = client.notify(client, 'workspace/didChangeConfiguration', {
        cmd = client.config.cmd,
      }, bufnr)
      -- if status then
      --   vim.notify('using local oxfmt: ' .. local_cmd)
      -- else
      --   vim.notify 'using global oxfmt'
      -- end
    end
  end,
}
