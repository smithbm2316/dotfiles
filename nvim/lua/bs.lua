bs = {}

bs.border = {
  chars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
  style = 'double',
}

-- rose-pine currently
bs.colors = {
  dark = {
    base = '#232136',
    surface = '#2a273f',
    overlay = '#393552',
    inactive = '#59546d',
    subtle = '#817c9c',
    text = '#e0def4',
    love = '#eb6f92',
    gold = '#f6c177',
    rose = '#ea9a97',
    pine = '#3e8fb0',
    foam = '#9ccfd8',
    iris = '#c4a7e7',
    highlight = '#312f44',
    highlight_inactive = '#2a283d',
    highlight_overlay = '#3f3c53',
  },
  light = {
    base = '#faf4ed',
    surface = '#fffaf3',
    overlay = '#f2e9de',
    inactive = '#9893a5',
    subtle = '#6e6a86',
    text = '#575279',
    love = '#b4637a',
    gold = '#ea9d34',
    rose = '#d7827e',
    pine = '#286983',
    foam = '#56949f',
    iris = '#907aa9',
    highlight = '#eee9e6',
    highlight_inactive = '#f2ede9',
    highlight_overlay = '#e4dfde',
  },
}

-- hijack vim.notify with nvim-notify
local ok, nvim_notify = pcall(require, 'notify')
if not ok then
  print 'nvim-notify not loaded'
  return
end

-- termguicolors needs to be set for nvim-notify
vim.opt.background = 'dark'
vim.opt.termguicolors = true

nvim_notify.setup {
  timeout = 3000,
  background_colour = 'Normal',
}

-- override default vim.notify behavior with plugin
vim.notify = function(msg, log_level, opts)
  log_level = log_level or 'debug'

  -- auto-convert tables to string interpretation so we can print it
  if type(msg) == 'table' then
    msg = vim.inspect(msg)
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
