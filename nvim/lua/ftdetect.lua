local ft_actions = {
  'TermOpen * startinsert',
  'FileType man,help,startuptime,qf,lspinfo nnoremap <buffer><silent> q :close<cr>',
}

for _, aucmd in ipairs(ft_actions) do
  vim.cmd('au! ' .. aucmd)
end

create_augroup('DenoShebangScript', {
  {
    events = 'BufRead',
    pattern = '*',
    callback = function()
      local first_line_arr = vim.api.nvim_buf_get_lines(0, 0, 1, false)

      if #first_line_arr > 0 and first_line_arr[1]:match '#!.*/usr/bin/env.*deno' then
        local ext_ft = first_line_arr[1]:match '--ext=.*%s*'
        if not ext_ft then
          vim.cmd.set 'ft=typescript'
          return
        end

        ext_ft = vim.trim(ext_ft:sub(7))
        -- dump(ext_ft)
        local ft_map = {
          js = 'javascript',
          jsx = 'javascriptreact',
          ts = 'typescript',
          tsx = 'typescriptreact',
        }
        vim.cmd.set('ft=' .. (ft_map[ext_ft] or 'typescript'))
      end
    end,
  },
})
