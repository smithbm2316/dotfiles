require('mini.pick').setup {
  mappings = {
    delete_left = '', -- default '<c-u>'
    scroll_down = '<c-d>',
    scroll_up = '<c-u>',
    -- TODO: implement a mapping that sends all items to quickfix/location list
    -- TODO: fix mapping to delete selected buffer in "Pick buffers" picker so
    -- that it redraws the screen
  },
  window = {
    config = function()
      local width = vim.api.nvim_get_option 'columns'
      local height = vim.api.nvim_get_option 'lines'
      return {
        relative = 'editor',
        anchor = 'NE',
        row = 0,
        col = width,
        width = math.ceil(width * 0.5),
        height = math.ceil(height * 0.5),
        style = 'minimal',
        border = 'double',
        mouse = true,
      }
    end,
  },
}

-- Files pickers
vim.keymap.set('n', '<leader>fj', function()
  MiniPick.builtin.files()
end, { desc = 'Find files (mini.pick)' })

vim.keymap.set('n', '<leader>fd', function()
  MiniPick.builtin.files(nil, {
    source = {
      cwd = vim.env.HOME .. '/dotfiles',
      name = 'Files (~/dotfiles)',
    },
  })
end, { desc = 'Find dotfiles (mini.pick)' })

vim.keymap.set('n', '<leader>fn', function()
  MiniPick.builtin.files(nil, {
    source = {
      cwd = vim.env.HOME .. '/dotfiles/nvim',
      name = 'Files (~/dotfiles/nvim)',
    },
  })
end, { desc = 'Find nvim files (mini.pick)' })

vim.keymap.set('n', '<leader>fs', function()
  MiniPick.builtin.files(nil, {
    source = {
      cwd = vim.env.HOME .. '/dotfiles/nvim-stable',
      name = 'Files (~/dotfiles/nvim-stable)',
    },
  })
end, { desc = 'Find nvim-stable files (mini.pick)' })

-- Grep Live pickers
vim.keymap.set('n', '<leader>gw', function()
  MiniPick.builtin.grep_live()
end, { desc = 'Grep word (mini.pick)' })

-- vim.keymap.set('n', '<leader>gW', function()
--   MiniPick.builtin.grep_live()
-- end, { desc = 'Grep word case-sensitive (mini.pick)' })

vim.keymap.set('n', '<leader>gid', function()
  MiniPick.builtin.grep_live(nil, {
    source = {
      cwd = vim.env.HOME .. '/dotfiles',
      name = 'Grep live (~/dotfiles)',
    },
  })
end, { desc = 'Grep in dotfiles (mini.pick)' })
vim.keymap.set('n', '<leader>gin', function()
  MiniPick.builtin.grep_live(nil, {
    source = {
      cwd = vim.env.HOME .. '/dotfiles/nvim',
      name = 'Grep live (~/dotfiles/nvim)',
    },
  })
end, { desc = 'Grep in nvim files (mini.pick)' })
vim.keymap.set('n', '<leader>gis', function()
  MiniPick.builtin.grep_live(nil, {
    source = {
      cwd = vim.env.HOME .. '/dotfiles/nvim-stable',
      name = 'Grep live (~/dotfiles/nvim-stable)',
    },
  })
end, { desc = 'Grep in nvim-stable files (mini.pick)' })

-- Miscellaneous pickers
vim.keymap.set('n', '<leader>gh', function()
  MiniPick.builtin.help()
end, { desc = 'Grep help (mini.pick)' })

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
end, { desc = 'Jump to buffer (mini.pick)' })

vim.keymap.set('n', '<leader>tp', function()
  MiniPick.builtin.resume()
end, { desc = 'Previous Pick picker (mini.pick)' })

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
