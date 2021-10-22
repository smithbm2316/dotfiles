require('auto-session').setup({
  log_level = 'error',
  auto_session_root_dir = vim.fn.stdpath('config') .. '/sessions/',
})
