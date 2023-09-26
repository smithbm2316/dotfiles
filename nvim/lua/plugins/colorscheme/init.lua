local catppuccin_ok, catppuccin = pcall(require, 'catppuccin')
if not catppuccin_ok then
  return
end

catppuccin.setup {
  flavour = 'mocha', -- latte, frappe, macchiato, mocha
  background = { -- :h background
    light = 'latte',
    dark = 'mocha',
  },
  transparent_background = false,
  show_end_of_buffer = false, -- show the '~' characters after the end of buffers
  term_colors = false,
  dim_inactive = {
    enabled = false,
    shade = 'dark',
    percentage = 0.15,
  },
  no_italic = false, -- Force no italic
  no_bold = false, -- Force no bold
  no_underline = false, -- Force no underline
  styles = {
    comments = { 'italic' },
    conditionals = { 'italic' },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  color_overrides = {},
  custom_highlights = {},
  integrations = {
    cmp = true,
    dap = true,
    harpoon = true,
    gitsigns = true,
    markdown = true,
    mini = true,
    neogit = true,
    -- native_lsp = true,
    notify = true,
    nvimtree = false,
    treesitter = true,
    treesitter_context = true,
    ts_rainbow = true,
    telekasten = true,
    telescope = true,
    lsp_trouble = true,
    which_key = true,
  },
}

-- rose-pine for light variant
local rose_pine_ok, rose_pine = pcall(require, 'rose-pine')
if not rose_pine_ok then
  return
end

rose_pine.setup {
  dark_variant = 'moon',
  highlight_groups = {
    IndentBlanklineChar = { fg = 'surface' },
    -- this seems to fix the issue with highlighting TSX/JSX component names in markup
    -- https://github.com/nvim-treesitter/playground/issues/94#issuecomment-1251134196
    -- ['@constructor'] = { fg = 'foam' },
  },
}

-- switch between light/dark theme
nnoremap('<leader>tt', function()
  if vim.opt.background:get() == 'dark' then
    vim.opt.background = 'light'
  else
    vim.opt.background = 'dark'
  end
end, 'Toggle color mode')

local current_sys_theme = vim.trim(vim.fn.system 'darkman get')
if current_sys_theme == 'light' then
  vim.cmd.colorscheme 'rose-pine-dawn'
else
  vim.cmd.colorscheme 'catppuccin-mocha'
end
