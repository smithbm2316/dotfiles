local zk = {}

require('zk').setup {
  debug = false,
  log = true,
  default_keymaps = false,
  default_notebook_path = vim.env.ZK_NOTEBOOK_DIR or '~/notes',
  fuzzy_finder = 'telescope', -- or 'telescope'
  link_format = 'wiki' -- or 'wiki'
}

zk.new = function()
  local opts = {
    title = vim.fn.input('Title: '),
    notebook = '',
    content = '',
    action = 'e',
    start_insert_mode = false,
  }
  require('zk.command').new(opts)
end

zk.cword_new_link = function()
  require('zk.command').create_note_link({ title = vim.fn.expand('<cword>') })
end

zk.visual_new_link = function()
  require('zk.command').create_note_link()
end

local function map_zk(keybind, func, mode)
  mode = mode or 'n'
  local command = string.format("<cmd>lua require('my.plugs.zk').%s()<cr>", func)
  vim.api.nvim_set_keymap(mode, keybind, command, { noremap = true })
end

map_zk('<leader>nn', 'new')
map_zk('<cr>', 'visual_new_link', 'x')
map_zk('<cr>', 'cword_new_link')

return zk
