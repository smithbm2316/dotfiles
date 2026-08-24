---@type vim.lsp.Config
return {
  -- use local installation of templ as a go tool
  cmd = function(dispatchers)
    local cmd = {}
    if vim.uv.fs_stat 'tools.go.mod' then
      cmd = { 'go', 'tool', '-modfile', 'tools.go.mod', 'templ', 'lsp' }
    else
      cmd = { 'go', 'tool', 'templ', 'lsp' }
    end

    return vim.lsp.rpc.start(cmd, dispatchers)
  end,
  filetypes = { 'templ' },
  root_markers = { 'go.mod', 'tools.go.mod', 'go.work', '.git' },
}
