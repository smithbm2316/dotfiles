-- thank you to @elijahmanor on Github for this plugin that I copied
-- https://github.com/elijahmanor/export-to-vscode.nvim
nnoremap('<leader>tv', function()
  local buffers = vim.api.nvim_list_bufs()
  local fileNames = {}

  for _, buffer in ipairs(buffers) do
    if vim.api.nvim_buf_is_valid(buffer) and vim.bo[buffer].buflisted then
      local fileName = vim.api.nvim_buf_get_name(buffer)

      if vim.api.nvim_get_current_buf() == buffer then
        local location = vim.api.nvim_win_get_cursor(0)
        fileName = fileName .. ':' .. location[1] .. ':' .. location[2] + 1
        table.insert(fileNames, 1, fileName)
      else
        table.insert(fileNames, fileName)
      end
    end
  end

  local binary = ''
  if vim.fn.executable 'code' == 1 then
    binary = 'code'
    print(binary)
  elseif vim.fn.executable 'codium' == 1 then
    binary = 'codium'
    print(binary)
  else
    vim.notify 'Could not find the `code` or `codium` executables installed'
    return
  end

  local cwd = vim.fn.getcwd()
  vim.cmd('!' .. binary .. ' -g ' .. cwd .. ' ' .. table.concat(fileNames, ' '))
end, 'Export session to vsc*de')
