return {
  'rmagatti/auto-session',
  lazy = false,
  config = function()
    vim.o.sessionoptions = 'buffers,curdir,help,tabpages,winpos,winsize'
    local auto_session = require 'auto-session'
    auto_session.setup {
      auto_session_root_dir = vim.fn.stdpath 'state' .. '/sessions/',
      auto_session_suppress_dirs = {
        '~/',
        '~/downloads',
      },
      auto_save_enabled = true,
      auto_restore_enabled = true,
      auto_session_enabled = true,
      -- disable telescope integration on startup
      session_lens = {
        load_on_setup = false,
      },
    }

    vim.keymap.set('n', '<leader>qa', function()
      auto_session.DeleteSession()
      vim.cmd.qa { bang = true }
    end, {
      desc = ':qa! + delete session',
    })
  end,
}
