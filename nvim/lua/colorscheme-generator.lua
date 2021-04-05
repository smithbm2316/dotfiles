-- This file creates a colorscheme from already available colorscheme

-- Author : Shadman Saleh
-- License : You can do whatever you want with it but do provide proper credit

-- Uses :
--   1. Copy this script to any &rtp/lua folder, most likely ~/.config/nvim/lua
--      so the script can be required
--   2. Run :lua require('colorscheme_generator').create('colorscheme_name', load_colorscheme)
--       colorscheme_name is the name of colorscheme, load_colorscheme is a boolean
--       that indicates whether to load the colorscheme or use currently
--       loaded highlights
--
-- It will create a basic vim colorscheme project in current
-- directory named color_name.nvim
--
-- If you want to remove any chance of plugin highlight groups, start neovim with nvim -u NONE to run this script

local bit = require'bit'

-- project_dir where plugin is created. By default it uses the current dir
local project_base_dir = '.'
local path_sep = package.config:sub(1,1)

-- nvim lua flags list
local FLAGS = {
  inverse         = '0x01',
  bold            = '0x02',
  italic          = '0x04',
  underline       = '0x08',
  undercurl       = '0x10',
  standout        = '0x20',
  strikethrough   = '0x40',
  nocombine       = '0x80',
  bg_indexed      = '0x0100',
  fg_indexed      = '0x0200',
  default         = '0x0400',
  global          = '0x0800',
}

local function create_project(color_name)
  local project_name = color_name .. '.nvim'

  -- create project directories
  vim.fn.mkdir(table.concat(
      {project_base_dir, project_name, 'colors'}, path_sep), 'p')
  vim.fn.mkdir(table.concat(
      {project_base_dir, project_name, 'lua', color_name}, path_sep), 'p')
end

local function write_boilerplate(color_name)
  local project_name = color_name .. '.nvim'

  -- open files
  local colorscheme_loader = io.open(table.concat(
       {project_base_dir, project_name, 'colors', color_name..'.vim'}, path_sep), 'w')
  local colorscheme_init = io.open(table.concat(
       {project_base_dir, project_name, 'lua', color_name, 'init.lua'}, path_sep), 'w')
  local colorscheme_utils = io.open(table.concat(
       {project_base_dir, project_name, 'lua', color_name, 'utils.lua'}, path_sep), 'w')
  local colorscheme_credits = io.open(table.concat(
       {project_base_dir, project_name, 'CREDITS.md'}, path_sep), 'w')
  local colorscheme_readme = io.open(table.concat(
       {project_base_dir, project_name, 'README.md'}, path_sep), 'w')

  -- write utils (lua/color_name/utils.lua)
  colorscheme_utils:write(string.format([[
-- Clear old highlights
local utils = {}

function utils.clear()
 vim.cmd('hi clear')
end

function utils.set_namespace(ns_name)
  -- Color namespace
  local ns = vim.api.nvim_create_namespace(ns_name)

  -- Activate namespace

  -- This API isn't stable yet. It will receive breaking changes
  -- and be renamed to nvim_set_hl_ns later be aware of that.
  -- for more details https://github.com/neovim/neovim/issues/14090#issuecomment-799285918
  vim.api.nvim__set_hl_ns(ns)
  return ns
end
return utils
]]))
  colorscheme_utils:close()

  -- write loader (colors/color_name.vim)
  colorscheme_loader:write(string.format([[
"load colorscheme
lua require("%s")
]], color_name))
  colorscheme_loader:close()

  -- write init (lua/color_name/init.lua)
  colorscheme_init:write(string.format([[
local utils = require('%s.utils')
local color_defs = require('%s.definitions')

local highlight = vim.api.nvim_set_hl

--clear old highlights
utils.clear()

-- Color namespace
local ns = utils.set_namespace("%s")

-- Set highlights
for color_name, param in pairs(color_defs) do
  highlight(ns, color_name, param)
end
]], color_name, color_name, color_name, color_name))
  colorscheme_init:close()

  -- write credits (CREDITS.md)
  colorscheme_credits:write([[
This colorscheme has been created by [colorscheme_generator](https://gist.github.com/shadmansaleh/101d27a3593a9765a81bc548370ba018)]])
  colorscheme_credits:close()

  -- write readme (README.md)
  colorscheme_readme:write(string.format([[
### %s

A colorscheme made for neovim.]], color_name))
  colorscheme_readme:close()
end

local function write_color_palette(palette, color_name)
  local project_name = color_name .. '.nvim'

  -- open files
  local colorscheme_palette = io.open(table.concat(
       {project_base_dir, project_name, 'lua', color_name, 'palette.lua'}, path_sep), 'w')

  -- write palette
  colorscheme_palette:write([[

-- =====================
-- =    Color palette   =
-- =====================

local palette = {

]])
  for _, color in pairs(palette) do
    colorscheme_palette:write(string.format([[
  %8s = %-8s, -- #%06x
]], color.color_name, color.value, color.value))
  end
  colorscheme_palette:write(
[[}

return palette]])
  colorscheme_palette:close()
end

local function write_color_defs(color_defs, inverse_palette, colorscheme_name)
  local project_name = colorscheme_name .. '.nvim'

  -- open files
  local colorscheme_defs = io.open(table.concat(
       {project_base_dir, project_name, 'lua', colorscheme_name, 'definitions.lua'}, path_sep), 'w')

  -- write highlight definitions
  colorscheme_defs:write(string.format([[
local palette = require("%s.palette")

-- =====================
-- = Color definitions =
-- =====================

local highlights = {
]], colorscheme_name))
  for _, highlight in pairs(color_defs) do
    local color_name = highlight.name
    local color = highlight.params
    if color.link then
      colorscheme_defs:write(string.format([[  %-10s = {link = '%s'}]],
          color_name, color.link) .. ',\n')
    else
      local command = string.format([[  %-10s = { ]], color_name)
      if color.foreground ~= nil then
        command = table.concat{command, 'fg = palette.',
            inverse_palette[color.foreground], ', '}
        color.foreground = nil
      end
      if color.background ~= nil then
        command = table.concat{command, 'bg = palette.',
            inverse_palette[color.background], ', '}
        color.background = nil
      end
      command = command .. string.gsub(string.match(
          vim.inspect(color), '{(.*)'), '\n', ' ') .. ',\n'
      colorscheme_defs:write(command)
    end
  end
  colorscheme_defs:write(
[[}

return highlights]])
  colorscheme_defs:close()
end

-- Add a color to color palette if it's not used yet
local function add_to_palette(color_num, color_palette, color_count)
  if not color_num then return color_palette, color_count end
  -- Check if already added
  local available = false
  for _, color  in pairs(color_palette) do
    if color.value == color_num then
      available = true
      break
    end
  end

  if not available then
    table.insert(color_palette,
        {color_name = 'color'..tostring(color_count), value = color_num})
    color_count = color_count + 1
  end
  return color_palette, color_count
end

-- Creates a color -> color_name lookup table from palette
local function get_inverse_palette(palette)
  local inverse_palette = {}
  for _, color in pairs(palette) do
    inverse_palette[color.value] = color.color_name
  end
  return inverse_palette
end

-- Creates a table of special params from special int
local function get_active_flags(special_param)
  local active_flags = {
    inverse         = false,
    bold            = false,
    italic          = false,
    underline       = false,
    undercurl       = false,
    standout        = false,
    strikethrough   = false,
    nocombine       = false,
    bg_indexed      = false,
    fg_indexed      = false,
    default         = false,
    global          = false,
  }
  for flag, _ in pairs(active_flags) do
    if bit.band(special_param, tonumber(FLAGS[flag], 16)) then
      active_flags[flag] = true
    end
  end
  -- remove false keys
  vim.tbl_filter(function(key) return active_flags[key] end, active_flags)
  return active_flags
end

local function load_colorscheme(color_name)
  -- clear old highlights
  vim.cmd('hi clear')
  -- apply colorscheme
  local ok, result = pcall(vim.cmd, 'colorscheme '..color_name)
  if not ok then
    print('Unable to create colorscheme. Error: '..result)
  end
  return ok
end

-- generates palettes and highlights table
local function gen_color_table()
  -- get set colors
  local highlights = vim.api.nvim__get_hl_defs(0)
  local color_groups = {}
  -- remove empty names
  vim.tbl_filter(function(key) return type(key) == 'string' and #key > 0 end, highlights)
  local count = 0
  local palette = {}
  -- Set special flags and add colors to palette
  for name,  highlight in pairs(highlights) do
    if type(name) == 'string' and #name > 0 then
      -- remove weird key
      highlight[true] = nil
      if not vim.tbl_isempty(highlight) then
        if highlight.special then
          vim.tbl_extend('keep', highlight, get_active_flags(highlight.special))
          highlight.special = nil
        end
        palette, count = add_to_palette(highlight.foreground, palette, count)
        palette, count = add_to_palette(highlight.background, palette, count)
        table.insert(color_groups, {name=name, params = highlight})
      end
    end
  end
  return color_groups, palette
end

-- creates a colorscheme
---@param color_name string: Name of colorscheme note
---    .nvim is always appended to project name as it uses
---     nvim_api from lua not present in vim
---@param load boolean:
---     Indicates whether to load colorscheme or use current
---     highlight groups. When true current highlights are
---     cleared and colorscheme name color_name is loaded
---     with colorscheme command
local function create(color_name, load)
  if load and not load_colorscheme(color_name) then return end
  local highlight_defs, color_palette = gen_color_table()
  table.sort(highlight_defs, function(l, r)
    if l.params.link == nil and r.params.link ~= nil then
      return true
    elseif l.params.link ~= nil and r.params.link == nil then
      return false
    else
      return l.name < r.name
    end
  end)
  local inverse_palette = get_inverse_palette(color_palette)
  create_project(color_name)
  write_boilerplate(color_name)
  write_color_palette(color_palette, color_name)
  write_color_defs(highlight_defs, inverse_palette, color_name)
end

return {
  create = create,
}
