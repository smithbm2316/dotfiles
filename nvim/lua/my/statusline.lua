-- table of possible vi_modes
local mode_map = {
  ['n'] = 'normal',
  ['niI'] = 'normal',
  ['niR'] = 'normal',
  ['niV'] = 'normal',
  ['no'] = 'n·op',
  ['nov'] = 'n·op',
  ['noV'] = 'n·op',
  ['no'] = 'n·op',
  ['v'] = 'visual',
  ['V'] = 'v·line',
  [''] = 'v·block',
  ['s'] = 'select',
  ['S'] = 's·line',
  [''] = 's·block',
  ['i'] = 'insert',
  ['ic'] = 'insert',
  ['ix'] = 'insert',
  ['R'] = 'replace',
  ['Rc'] = 'replace',
  ['Rv'] = 'v·replace',
  ['c'] = 'command',
  ['cv'] = 'vim ex',
  ['ce'] = 'ex',
  ['r'] = 'prompt',
  ['rm'] = 'more',
  ['r?'] = 'confirm',
  ['!'] = 'shell',
  ['t'] = 'terminal',
}

-- configure these colors to change what are used below
local colorscheme = {
  normal = '#74dfc4',
  insert = '#f97e72',
  visual = '#b381c5',
  select = '#74dfc4',
  replace = '#ffe261',
  command = '#40b4c4',
  nop = '#f97e72',
  misc = '#716385',
  terminal = '#65606a',
  bg = '#eb64b9',
  fg = '#27212e',
  fg_light = '#e0dfe1',
  not_current = '#716385',
  buf_current = '#40b4c4',
  git_info = '#b381c5',
}

-- colors for mode_mappings
local mode_colors = {
  normal = colorscheme.normal,
  ['n·op'] = colorscheme.nop,
  insert = colorscheme.insert,
  visual = colorscheme.visual,
  ['v·line'] = colorscheme.visual,
  ['v·block'] = colorscheme.visual,
  select = colorscheme.select,
  ['s·line'] = colorscheme.select,
  ['s·block'] = colorscheme.select,
  replace = colorscheme.replace,
  ['v·replace'] = colorscheme.replace,
  command = colorscheme.command,
  ['vim ex'] = colorscheme.command,
  ex = colorscheme.command,
  prompt = colorscheme.misc,
  more = colorscheme.misc,
  confirm = colorscheme.misc,
  shell = colorscheme.misc,
  terminal = colorscheme.terminal,
}

-- Statusline highlights helper
local function statusline_hl(component, fg, bg)
  local hl_command = string.format('hi StatusLine%s guifg=%s guibg=%s gui=none', component, fg, bg)
  vim.cmd(hl_command)
end

-- main part of the statusline
statusline_hl('', colorscheme.fg, colorscheme.bg)
-- main part of the statusline when it's not the current buffer
statusline_hl('NC', colorscheme.fg_light, colorscheme.not_current)
-- statusline mode
statusline_hl('ViMode', colorscheme.fg, colorscheme.normal)
-- statusline current buffer
statusline_hl('BufCurrent', colorscheme.fg, colorscheme.buf_current)
-- statusline git info
statusline_hl('GitInfo', colorscheme.fg, colorscheme.git_info)

-- function for retrieving the current mode
local function vi_mode()
  local m = vim.api.nvim_get_mode().mode
  if mode_map[m] == nil then
    vim.api.nvim_exec(string.format('highlight StatuslineViMode guibg=%s', mode_colors['normal']), false)
    return string.format(' %s ', m)
  else
    vim.api.nvim_exec(string.format('highlight StatuslineViMode guibg=%s', mode_colors[mode_map[m]]), false)
    return string.format(' %s ', mode_map[m])
  end
end

-- git info from gitsigns
local function gitsigns_info()
  local branch = vim.b.gitsigns_head
  local diff = vim.b.gitsigns_status
  if branch then
    if diff ~= '' then
      return string.format('  %s | %s ', branch, diff)
    else
      return string.format('  %s ', branch)
    end
  else
    return ''
  end
end

-- filetype and filename info with icons
local function file_icon()
  local bufpath = vim.api.nvim_buf_get_name(0)
  local bufname = string.match(bufpath, '/([^/]+)$') or ''
  local ft = vim.api.nvim_buf_get_option(0, 'filetype') or ''
  local icon = require('nvim-web-devicons').get_icon(bufname, ft, { default = true }) or ''

  return icon
end

-- wrapper for formatting a component for the statusline
local function component(hlgroup, item)
  return '%#' .. hlgroup .. '#' .. item .. '%#' .. hlgroup .. '#'
end

-- all components for the statusline in a lua table
-- TODO: figure out how to make icons and gitinfo work for separated windows
function statusline_active()
  local bufname = vim.api.nvim_exec("echo expand('%:t')", true)
  local ft = vim.api.nvim_exec("echo &ft", true)
  local icon = require('nvim-web-devicons').get_icon(bufname, ft, { default = true }) or ''

  local statusline_tbl = {
    component('StatuslineViMode', vi_mode()),
    component('StatuslineBufCurrent', string.format(' %s %s ', icon, '%t%m')),
    component('StatuslineGitInfo', gitsigns_info()),
    component('StatuslineEmptySpace', '%='),
    component('StatuslineObsession', '%{ObsessionStatus()}'),
    component('StatuslineFiletype', string.format(' [%s %s] ', icon, '%Y')),
    component('StatuslineLinesColumns', '[%l/%L] [%c] '),
  }
  return table.concat(statusline_tbl)
end

function statusline_inactive()
  local statusline_tbl = {
    string.format(' %s %s ', file_icon(), '%t%m'),
    '%=',
    '%{ObsessionStatus()}',
    string.format(' [%s %s] ', file_icon(), '%Y'),
    '[%l/%L] [%c] ',
  }
  return table.concat(statusline_tbl)
end

-- set statusline to concatenated table from above
vim.api.nvim_exec([[
  augroup Statusline
    autocmd!
    autocmd BufEnter * setlocal statusline=%!v:lua.statusline_active()
    autocmd BufLeave * setlocal statusline=%!v:lua.statusline_inactive()
  augroup END
]], false)
