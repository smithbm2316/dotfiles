local harpoon_status = function()
  local has_harpoon, harpoon_mark = pcall(require, 'harpoon.mark')
  if has_harpoon then
    local status = harpoon_mark.status()
    if status ~= '' then
      return 'Harpoon ' .. status
    end
  end
  return ''
end

local gps = require 'nvim-gps'
gps.setup {

  icons = {
    ['class-name'] = ' ', -- Classes and class-like objects
    ['function-name'] = ' ', -- Functions
    ['method-name'] = ' ', -- Methods (functions inside class-like objects)
    ['container-name'] = '⛶ ', -- Containers (example: lua tables)
    ['tag-name'] = '炙', -- Tags (example: html tags)
  },

  -- Add custom configuration per language or
  -- Disable the plugin for a language
  -- Any language not disabled here is enabled by default
  languages = {
    -- Some languages have custom icons
    ['json'] = {
      icons = {
        ['array-name'] = ' ',
        ['object-name'] = ' ',
        ['null-name'] = '[] ',
        ['boolean-name'] = 'ﰰﰴ ',
        ['number-name'] = '# ',
        ['string-name'] = ' ',
      },
    },
    ['toml'] = {
      icons = {
        ['table-name'] = ' ',
        ['array-name'] = ' ',
        ['boolean-name'] = 'ﰰﰴ ',
        ['date-name'] = ' ',
        ['date-time-name'] = ' ',
        ['float-name'] = ' ',
        ['inline-table-name'] = ' ',
        ['integer-name'] = '# ',
        ['string-name'] = ' ',
        ['time-name'] = ' ',
      },
    },
    ['yaml'] = {
      icons = {
        ['mapping-name'] = ' ',
        ['sequence-name'] = ' ',
        ['null-name'] = '[] ',
        ['boolean-name'] = 'ﰰﰴ ',
        ['integer-name'] = '# ',
        ['float-name'] = ' ',
        ['string-name'] = ' ',
      },
    },

    -- Disable for particular languages
    -- ["bash"] = false, -- disables nvim-gps for bash
    -- ["go"] = false,   -- disables nvim-gps for golang

    -- Override default setting for particular languages
    -- ["ruby"] = {
    --	separator = '|', -- Overrides default separator with '|'
    --	icons = {
    --		-- Default icons not specified in the lang config
    --		-- will fallback to the default value
    --		-- "container-name" will fallback to default because it's not set
    --		["function-name"] = '',    -- to ensure empty values, set an empty string
    --		["tag-name"] = ''
    --		["class-name"] = '::',
    --		["method-name"] = '#',
    --	}
    --}
  },

  separator = ' > ',

  -- limit for amount of context shown
  -- 0 means no limit
  -- Note: to make use of depth feature properly, make sure your separator isn't something that can appear
  -- in context names (eg: function names, class names, etc)
  depth = 0,

  -- indicator used when context is hits depth limit
  depth_limit_indicator = '..',
}

require('lualine').setup {
  options = {
    theme = 'rose-pine',
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    icons_enabled = true,
    lower = true,
  },
  sections = {
    lualine_a = {
      --[[ {
        'mode',
        fmt = function(str)
          return str:sub(1, 1)
        end,
      }, ]]
      'mode',
    },
    lualine_b = {
      {
        'filename',
        path = 1,
        lower = false,
        shorting_target = 70,
      },
    },
    lualine_c = {
      {
        'branch',
        color = { fg = '#c4a7e7' },
        separator = { right = '' },
      },
      {
        'diff',
        colored = true,
        color_added = { fg = '#266d6a' },
        color_modified = { fg = '#536c9e' },
        color_removed = { fg = '#b2555b' },
        symbols = { added = '+', modified = '~', removed = '-' },
      },
    },
    lualine_x = {
      {
        harpoon_status,
        color = 'HarpoonWindow',
      },
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        sections = { 'error', 'warn', 'info' },
        color_error = { fg = '#db4b4b' },
        color_warn = { fg = '#e0af68' },
        color_info = { fg = '#1abc9c' },
        symbols = {
          error = ' ',
          warn = ' ',
          info = ' ',
        },
        separator = { left = '|' },
      },
    },
    lualine_y = { 'filetype' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = { 'filename' },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { 'filetype' },
    lualine_z = { 'location' },
  },
  tabline = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {
      {
        gps.get_location,
        cond = gps.is_available,
      },
    },
    lualine_y = {},
    lualine_z = {},
  },
}
