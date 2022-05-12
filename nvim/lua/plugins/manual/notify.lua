-- TODO: fix issue with flickering in Wezterm
-- https://github.com/rcarriga/nvim-notify/issues/63

-- hijack vim.notify with nvim-notify
local ok, nvim_notify = pcall(require, 'notify')
if not ok then
  print 'nvim-notify not loaded'
  return
end

nvim_notify.setup {
  level = 'trace',
  timeout = 3000,
  background_colour = 'Normal',
  render = 'default',
}

vim.lsp.set_log_level(vim.log.levels.ERROR)

-- override default vim.notify behavior with plugin
vim.notify = function(msg, log_level, opts)
  log_level = log_level or vim.log.levels.DEBUG

  -- auto-convert tables to string interpretation so we can print it
  if type(msg) == 'table' then
    msg = vim.inspect(msg)
  elseif not msg then
    print 'uhhhhhhhh'
    msg = 'nil'
  end
  nvim_notify(msg, log_level, opts)
end

-- load telescope extension
local has_telescope, telescope = pcall(require, 'telescope')
if has_telescope then
  telescope.load_extension 'notify'
end

-- clear any active notifications
nnoremap('<leader>nc', function()
  nvim_notify.dismiss { pending = true }
end, 'Notification clear')

-- show history of notify notifications
nnoremap('<leader>nh', function()
  telescope.extensions.notify.notify()
end, 'Notification history')
