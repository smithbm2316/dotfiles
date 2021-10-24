_G.Markdown_Screen_Movement = function(movement, mode)
  if vim.api.nvim_win_get_option(0, 'wrap') then
    movement = 'g' .. movement
  end
  nv.feedkeys(movement, mode, false)
end

local keys = { 'j', 'k', '0', '^', '$' }
local rhs = [[<cmd>lua Markdown_Screen_Movement(%q, %q)<cr>]]

for _, key in ipairs(keys) do
  nnoremap(key, rhs:format(key, 'n'), { expr = true, buffer = true })
  onoremap(key, rhs:format(key, 'o'), { expr = true, buffer = true })
end

vim.g.markdown_fenced_languages = {
  'bash',
  'c',
  'cpp',
  'css',
  'go',
  'html',
  'javascript',
  'lua',
  'python',
  'rust',
  'scss',
  'sh',
  'typescript',
  'vim',
  'zsh',
}

vim.cmd 'syntax on'
