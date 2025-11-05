---@type fun(expand?: boolean): fun(): vim.api.keyset.win_config
local get_win_config = function(expand)
  return function()
    local columns = vim.api.nvim_get_option_value('columns', {})
    local lines = vim.api.nvim_get_option_value('lines', {})

    local col = 0
    local width = columns
    local height = math.ceil(lines * 0.5)
    if columns > 140 then
      width = expand and math.ceil(columns * 0.6) or math.ceil(columns * 0.4)
      col = width
    end

    ---@type vim.api.keyset.win_config
    return {
      relative = 'editor',
      -- anchor = 'NE',
      row = 0,
      col = col,
      width = width,
      height = height,
      style = 'minimal',
      border = 'double',
      mouse = true,
    }
  end
end

require('mini.pick').setup {
  mappings = {
    caret_left = '<left>',
    caret_right = '<right>',

    choose = '<cr>',
    choose_in_split = '<c-s>',
    choose_in_tabpage = '<c-t>',
    choose_in_vsplit = '<c-v>',
    choose_marked = '<m-cr>',

    delete_char = '<bs>',
    delete_char_right = '<del>',
    delete_left = '<c-u>',
    delete_word = '<c-w>',

    mark = '<c-x>',
    mark_all = '<c-a>',

    move_down = '<c-n>',
    move_start = '<c-g>',
    move_up = '<c-p>',

    paste = '<c-r>',

    refine = '<c-k>', -- default <c-space>
    refine_marked = '<c-j>', -- default <m-space>

    scroll_down = '<c-f>',
    scroll_left = '<c-h>',
    scroll_right = '<c-l>',
    scroll_up = '<c-b>',

    stop = '<esc>',

    toggle_info = '<s-tab>',
    toggle_preview = '<tab>',

    -- TODO: implement a mapping that sends all items to quickfix/location list
    -- TODO: fix mapping to delete selected buffer in "Pick buffers" picker so
    -- that it redraws the screen
  },
  window = {
    config = get_win_config(),
  },
}
require('mini.extra').setup()
vim.ui.select = MiniPick.ui_select

-- Files pickers
vim.keymap.set(
  'n',
  '<leader>fj',
  MiniPick.builtin.files,
  { desc = '[f]ind and [j]ump to file in cwd (mini.pick)' }
)

vim.keymap.set('n', '<leader>fd', function()
  MiniPick.builtin.files(nil, {
    source = {
      cwd = vim.env.HOME .. '/dotfiles',
      name = 'Files (~/dotfiles)',
    },
  })
end, { desc = '[f]ind [d]otfiles (mini.pick)' })

vim.keymap.set('n', '<leader>fn', function()
  MiniPick.builtin.files(nil, {
    source = {
      cwd = vim.env.HOME .. '/dotfiles/nvim',
      name = 'Files (~/dotfiles/nvim)',
    },
  })
end, { desc = '[f]ind [n]vim files (mini.pick)' })

vim.keymap.set('n', '<leader>fs', function()
  MiniPick.builtin.files(nil, {
    source = {
      cwd = vim.env.HOME .. '/dotfiles/nvim-stable',
      name = 'Files (~/dotfiles/nvim-stable)',
    },
  })
end, { desc = '[f]ind nvim-[s]table files (mini.pick)' })

-- Grep Live pickers
vim.keymap.set('n', '<leader>gw', function()
  MiniPick.builtin.grep_live(nil, {
    window = { config = get_win_config(true) },
  })
end, { desc = '[g]rep [w]ord (mini.pick)' })

-- vim.keymap.set('n', '<leader>gW', function()
--   MiniPick.builtin.grep_live()
-- end, { desc = '[g]rep [W]ord case-sensitive (mini.pick)' })

vim.keymap.set('n', '<leader>gid', function()
  MiniPick.builtin.grep_live(nil, {
    source = {
      cwd = vim.env.HOME .. '/dotfiles',
      name = 'Grep live (~/dotfiles)',
    },
    window = { config = get_win_config(true) },
  })
end, { desc = '[g]rep [i]n [d]otfiles (mini.pick)' })
vim.keymap.set('n', '<leader>gin', function()
  MiniPick.builtin.grep_live(nil, {
    source = {
      cwd = vim.env.HOME .. '/dotfiles/nvim',
      name = 'Grep live (~/dotfiles/nvim)',
    },
    window = { config = get_win_config(true) },
  })
end, { desc = '[g]rep [i]n [n]vim files (mini.pick)' })
vim.keymap.set('n', '<leader>gis', function()
  MiniPick.builtin.grep_live(nil, {
    source = {
      cwd = vim.env.HOME .. '/dotfiles/nvim-stable',
      name = 'Grep live (~/dotfiles/nvim-stable)',
    },
    window = { config = get_win_config(true) },
  })
end, { desc = 'Grep in nvim-stable files (mini.pick)' })

-- Miscellaneous pickers
vim.keymap.set('n', '<leader>gh', function()
  MiniPick.builtin.help()
end, { desc = '[g]rep [h]elp (mini.pick)' })

vim.keymap.set('n', '<leader>jb', function()
  MiniPick.builtin.buffers(nil, {
    mappings = {
      wipeout = {
        char = '<c-x>',
        func = function()
          vim.api.nvim_buf_delete(
            MiniPick.get_picker_matches().current.bufnr,
            {}
          )
        end,
      },
    },
  })
end, { desc = '[j]ump to [b]uffer (mini.pick)' })

vim.keymap.set(
  'n',
  '<leader>tp',
  MiniPick.builtin.resume,
  { desc = '[t]elescope [p]revious Pick picker (mini.pick)' }
)
vim.keymap.set(
  'n',
  '<leader>jp',
  MiniPick.builtin.resume,
  { desc = '[j]ump to [p]revious Pick picker (mini.pick)' }
)

-- keymaps using 'mini.extra' pickers
vim.keymap.set(
  'n',
  '<leader>gk',
  MiniExtra.pickers.keymaps,
  { desc = '[g]rep [k]eymaps' }
)
vim.keymap.set(
  'n',
  '<leader>ge',
  MiniExtra.pickers.commands,
  { desc = '[g]rep [e]x-commands' }
)

-- Adding custom picker to pick `register` entries
MiniPick.registry.registry = function()
  local items = vim.tbl_keys(MiniPick.registry)
  table.sort(items)
  local source = { items = items, name = 'Registry', choose = function() end }
  local chosen_picker_name = MiniPick.start { source = source }
  if chosen_picker_name == nil then
    return
  end
  return MiniPick.registry[chosen_picker_name]()
end
