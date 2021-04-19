local M = {}

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
  normal = '#eb64b9',
  nop = '#f97e72',
  insert = '#74dfc4',
  visual = '#b381c5',
  select = '#ffe261',
  replace = '#74dfc4',
  command = '#40b4c4',
  misc = '#716385',
  terminal = '#65606a',
  bg = '#eb64b9',
  fg = '#27212e',
  fg_light = '#e0dfe1',
  not_current = '#b381c5',
  buf_current = '#40b4c4',
  vi_mode = '#27212e',
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
statusline_hl('NC', colorscheme.fg, colorscheme.not_current)
-- statusline mode
statusline_hl('ViMode', colorscheme.fg_light, colorscheme.vi_mode)
-- statusline current buffer
statusline_hl('BufCurrent', colorscheme.fg, colorscheme.buf_current)
-- statusline git info
statusline_hl('GitInfo', colorscheme.fg, colorscheme.git_info)

-- function for retrieving the current mode
function M.vi_mode()
	local m = vim.api.nvim_get_mode().mode
	if mode_map[m] == nil then
    vim.api.nvim_exec(string.format('highlight StatuslineViMode guifg=%s', mode_colors['normal']), false)
    return m
  else
    vim.api.nvim_exec(string.format('highlight StatuslineViMode guifg=%s', mode_colors[mode_map[m]]), false)
    --[[ local mode_highlight = vim.api.nvim_exec('highlight StatuslineMode', true)
    print(vim.trim(mode_highlight))  ]]
    return mode_map[m]
  end
end

-- git info
local function git_info()
  local branch = vim.trim(vim.fn.system('git branch --show-current'))
  if string.match(branch, 'fatal') == nil then
    return '  ' .. branch .. ' '
  else
    return ''
  end
end

-- wrapper for formatting a component for the statusline
local function component(hlgroup, item)
  return '%#' .. hlgroup .. '#' .. item .. '%#' .. hlgroup .. '#'
end

-- all components for the statusline in a lua table
local lua_statusline = {
  component('StatuslineViMode', [[ %{luaeval("require('my.statusline').vi_mode()")} ]]),
  component('StatuslineBufCurrent', ' %t%m%r '),
  component('StatuslineGitInfo', git_info()),
  component('StatuslineEmptySpace', '%='),
  component('StatuslineFiletype', ' %y '),
  component('StatuslineLinesColumns', '[%l/%L] [%c] '),
}

-- set statusline to concatenated table from above
vim.o.statusline = table.concat(lua_statusline)

-- return the M table so that the vi_mode() function is available globally
return M
