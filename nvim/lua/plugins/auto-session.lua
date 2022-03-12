local has_auto_session, auto_session = pcall(require, 'auto-session')
if has_auto_session then
  auto_session.setup {
    log_level = 'error',
    auto_session_root_dir = vim.fn.stdpath 'config' .. '/sessions/',
  }
end
