local lsp = require('feline.providers.lsp')
local vi_mode_utils = require('feline.providers.vi_mode')

-- colors to use throughout the file
local colorscheme = {
  pink = '#eb64b9',
  yellow = '#ffe261',
  orange = '#f97e72',
  green = '#74dfc4',
  blue = '#40b4c4',
  purple = '#b381c5',
  purple_gray = '#716385',
  gray = '#65606a',
  dark = '#27212e',
  white = '#e0dfe1',
}

local properties = {
  force_inactive = {
    filetypes = {
      'NvimTree',
      'dbui',
      'packer',
      'startify',
      'fugitive',
      'fugitiveblame'
    },
    buftypes = {},
    bufnames = {}
  }
}

local components = {
  left = {
    active = {},
    inactive = {}
  },
  right = {
    active = {},
    inactive = {}
  }
}

------------------------------------------------------------
--- LEFT SIDE
------------------------------------------------------------
-- fun little bar
components.left.active[1] = {
  provider = '▊ ',
  hl = {
    fg = colorscheme.blue
  }
}

-- vi_mode indicator
components.left.active[2] = {
  provider = 'vi_mode',
  hl = function()
    return {
      name = vi_mode_utils.get_mode_highlight_name(),
      fg = vi_mode_utils.get_mode_color(),
      style = 'bold'
    }
  end,
  right_sep = ' ',
}

-- name of current file
file_info_hl = { fg = colorscheme.pink, bg = colorscheme.green }
components.left.active[3] = {
  provider = 'file_info',
  hl = {
    fg = colorscheme.dark,
    bg = colorscheme.green,
    style = 'bold'
  },
  left_sep = {
    { str = 'slant_right', hl = file_info_hl },
    { str = ' ', hl = file_info_hl },
  },
  right_sep = {
    { str = ' ', hl = file_info_hl },
    { str = 'slant_left', hl = file_info_hl }
  }
}

-- current git branch we are on
components.left.active[4] = {
  provider = 'git_branch',
  hl = {
    fg = colorscheme.dark,
    bg = colorscheme.blue,
    style = 'bold'
  },
  left_sep = 'slant_left'
}

-- how many additions were made to the current file
-- according to git
components.left.active[5] = {
  provider = 'git_diff_added',
  hl = {
    fg = colorscheme.dark,
    bg = colorscheme.blue,
    style = 'bold'
  },
}

-- how many lines were changed in the current file
-- according to git
components.left.active[6] = {
  provider = 'git_diff_changed',
  hl = {
    fg = colorscheme.dark,
    bg = colorscheme.blue,
    style = 'bold'
  },
}

-- how many lines were deleted in the current file
-- according to git
components.left.active[7] = {
  provider = 'git_diff_removed',
  hl = {
    fg = colorscheme.dark,
    bg = colorscheme.blue,
    style = 'bold'
  },
  right_sep = {
    {
      str = ' ',
      hl = {
        fg = 'NONE',
        bg = colorscheme.blue,
      }
    },
    'slant_right'
  }
}

-- show lsp errors
components.left.active[8] = {
  provider = 'diagnostic_errors',
  enabled = function() return lsp.diagnostics_exist('Error') end,
  hl = { fg = colorscheme.orange, bg = colorscheme.dark }
}

-- show lsp warnings
components.left.active[9] = {
  provider = 'diagnostic_warnings',
  enabled = function() return lsp.diagnostics_exist('Warning') end,
  hl = { fg = colorscheme.yellow, bg = colorscheme.dark }
}

-- show lsp hints
components.left.active[10] = {
  provider = 'diagnostic_hints',
  enabled = function() return lsp.diagnostics_exist('Hint') end,
  hl = { fg = colorscheme.blue, bg = colorscheme.dark }
}

-- show lsp info
components.left.active[11] = {
  provider = 'diagnostic_info',
  enabled = function() return lsp.diagnostics_exist('Information') end,
  hl = { fg = colorscheme.green, bg = colorscheme.dark }
}

------------------------------------------------------------
--- RIGHT SIDE
------------------------------------------------------------
-- row/column in file
position_hl = { fg = colorscheme.pink, bg = colorscheme.yellow }
position_icon_hl = { fg = colorscheme.dark, bg = colorscheme.yellow }
components.right.active[1] = {
  provider = 'position',
  hl = {
    fg = colorscheme.dark,
    bg = colorscheme.yellow,
    style = 'bold'
  },
  left_sep = {
    { str = 'slant_right_2', hl = position_hl },
    { str = ' ', hl = position_hl },
    { str = ' ', hl = position_icon_hl },
  },
  right_sep = {
    { str = ' ', hl = position_icon_hl },
    { str = ' ', hl = position_hl },
    { str = 'slant_left_2', hl = position_hl }
  }
}

-- file size
file_size_hl = { fg = colorscheme.pink, bg = colorscheme.purple }
file_size_icon_hl = { fg = colorscheme.dark, bg = colorscheme.purple }
components.right.active[2] = {
  provider = 'file_size',
  hl = {
    fg = colorscheme.dark,
    bg = colorscheme.purple,
    style = 'bold'
  },
  left_sep = {
    { str = 'slant_right', hl = file_size_hl },
    { str = ' ', hl = file_size_hl },
    { str = ' ', hl = file_size_icon_hl }
  },
  right_sep = {
    { str = ' ', hl = file_size_hl },
    { str = 'slant_left', hl = file_size_hl }
  }
}

-- what percentage of the file I am currently at
line_percentage_hl = { fg = colorscheme.pink, bg = colorscheme.dark }
components.right.active[3] = {
  provider = 'line_percentage',
  hl = {
    fg = colorscheme.pink,
    bg = colorscheme.dark,
    style = 'bold'
  },
  left_sep = {
    { str = 'slant_right_2', hl = line_percentage_hl },
    { str = ' ﴜ ', hl = line_percentage_hl }
  },
  right_sep = {
    { str = ' ', hl = line_percentage_hl },
    { str = 'slant_left_2', hl = line_percentage_hl }
  }
}

-- scroll bar mirroring the percentage into the file I am
components.right.active[4] = {
  provider = 'scroll_bar',
  hl = {
    fg = colorscheme.blue,
    style = 'bold'
  },
  left_sep = ' '
}

-- inactive components
-- fun little bar
components.left.inactive[1] = {
  provider = '▊ ',
  hl = {
    fg = colorscheme.blue
  }
}

-- vi_mode indicator
components.left.inactive[2] = {
  provider = 'vi_mode',
  hl = function()
    return {
      name = vi_mode_utils.get_mode_highlight_name(),
      fg = vi_mode_utils.get_mode_color(),
      style = 'bold'
    }
  end,
  right_sep = ' ',
}

-- filetype info
file_type_hl = { fg = colorscheme.pink, bg = colorscheme.green }
components.left.inactive[3] = {
  provider = 'file_type',
  hl = {
    fg = colorscheme.dark,
    bg = colorscheme.green,
    style = 'bold'
  },
  left_sep = {
    { str = 'slant_right', hl = file_type_hl },
    { str = ' ', hl = file_type_hl },
  },
  right_sep = {
    { str = ' ', hl = file_type_hl },
    { str = 'slant_left', hl = file_type_hl }
  }
}

-- blank rest of the bar
components.left.inactive[4] = {
  provider = '',
  hl = {
    fg = colorscheme.dark,
    bg = colorscheme.pink,
  }
}

-- colors for vi_mode indicator
local vi_mode_colors = {
  NORMAL = colorscheme.dark, 
  OP = colorscheme.orange,
  INSERT = colorscheme.green,
  VISUAL = colorscheme.purple,
  BLOCK = colorscheme.purple,
  REPLACE = colorscheme.green,
  ['V-REPLACE'] = colorscheme.purple,
  ENTER = colorscheme.purple_gray,
  MORE = colorscheme.purple_gray,
  SELECT = colorscheme.purple_gray,
  COMMAND = colorscheme.blue,
  SHELL = colorscheme.yellow,
  TERM = colorscheme.gray,
  NONE = colorscheme.dark
}

require('feline').setup({
  default_fg = colorscheme.dark,
  default_bg = colorscheme.pink,
  components = components,
  properties = properties,
  vi_mode_colors = vi_mode_colors,
})
