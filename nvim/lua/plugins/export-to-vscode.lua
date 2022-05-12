nnoremap('<leader>oiv', function()
  local ok, export_to_vscode = pcall(require, 'export-to-vscode')
  if not ok then
    return
  end
  export_to_vscode.launch()
end, 'Open current buffers in vsc*de')
