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
local has_nvim_notify, nvim_notify = pcall(require, 'notify')
if has_nvim_notify then
  vim.notify = function(msg, log_level, opts)
    local default_opts = { timeout = 500 }
    opts = opts and vim.tbl_deep_extend('force', default_opts, opts) or default_opts
    nvim_notify(msg, log_level, opts)
  end
end
