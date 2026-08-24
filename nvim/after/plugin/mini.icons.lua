---@alias Icon { hl: string, glyph: string }

---@type table<string, Icon>
local shared = {
  jinja = {
    hl = 'MiniIconsRed',
    glyph = '',
  },
  templ = {
    glyph = '󰅴',
    hl = 'MiniIconsBlue',
  },
}

require('mini.icons').setup {
  -- file = {},
  ---@type table<string, Icon>
  extension = {
    dbml = {
      hl = 'MiniIconsPurple',
      glyph = '󰮆',
    },
    jinja = shared.jinja,
    j2 = shared.jinja,
    templ = shared.templ,
    tmpl = shared.tmpl,
  },
}
