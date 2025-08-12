---@diagnostic disable: undefined-global, param-type-mismatch

local LOCAL_SESSION_FILE = 'Session.vim'

require('mini.sessions').setup {
  autoread = true,
  autowrite = true,
  file = LOCAL_SESSION_FILE,
  force = {
    read = true,
    write = true,
    delete = true,
  },
  verbose = {
    read = false,
    write = false,
    delete = false,
  },
}

vim.keymap.set('n', '<leader>qa', function()
  if MiniSessions.detected[LOCAL_SESSION_FILE] ~= nil then
    MiniSessions.delete(LOCAL_SESSION_FILE)
    -- vim.notify 'Session deleted!'
  end
  vim.cmd 'qa!'
end, { desc = '[q]uit [a]ll and delete current session' })

vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('AutoloadMiniSession', { clear = true }),
  callback = function(_args)
    if
      type(MiniSessions) == 'table'
      and type(MiniSessions.detected) == 'table'
      and MiniSessions.detected[LOCAL_SESSION_FILE] == nil
    then
      MiniSessions.write(LOCAL_SESSION_FILE)
      -- vim.notify 'Began and saved a new session.'
    end
  end,
})
