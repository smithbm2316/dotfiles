return {
  'rmagatti/auto-session',
  priority = 500,
  opts = {
    auto_session_root_dir = vim.fn.stdpath 'state' .. '/sessions/',
    session_lens = {
      -- disable telescope integration on startup
      load_on_setup = false,
    },
  },
  config = function(_, opts)
    vim.o.sessionoptions = 'buffers,curdir,help,tabpages,winpos,winsize'
    local auto_session = require 'auto-session'
    auto_session.setup(opts)

    vim.keymap.set('n', '<leader>qa', function()
      auto_session.DeleteSession()
      vim.cmd.qa { bang = true }
    end, {
      desc = ':qa! + delete session',
    })
  end,
}
