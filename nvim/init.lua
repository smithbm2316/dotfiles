-- Make sure to setup `mapleader` and `maplocalleader` before all other things
-- so that all keymaps use the correct <leader> and <localleader> key
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- load my global helpers, default settings, and non-plugin specific keymaps
require 'globals'
local disabled_plugins = require 'disable_rtp_plugins'
require 'settings'
require 'maps'

-- if we are using VSCode, exit before we set up all our other configuration
if vim.g.vscode then
  return
end

require 'diagnostics'

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    lazyrepo,
    lazypath,
  }
end
-- Add lazy to the `runtimepath`, this allows us to `require` it.
vim.opt.rtp:prepend(lazypath)

vim.cmd [[
augroup CloseNeovimWithQFileTypes
  au!
  au FileType man,help,startuptime,qf,lspinfo nnoremap <buffer><silent> q :close<cr>
augroup END
]]

-- Setup lazy.nvim
require('lazy').setup {
  spec = {
    { import = 'plugins' },
  },
  install = {
    colorscheme = { 'catppuccin-mocha' },
  },
  checker = {
    -- automatically check for plugin updates
    enabled = false,
    ---@type number? set to 1 to check for updates very slowly
    concurrency = 1,
    -- get a notification when new updates are found
    notify = false,
    -- in seconds, check once a day
    frequency = 86400,
    -- check for pinned packages that can't be updated
    check_pinned = false,
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = false,
    -- get a notification when changes are found
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = disabled_plugins,
    },
  },
}
vim.keymap.set('n', '<leader>ll', '<cmd>Lazy<cr>', { desc = 'Lazy.nvim UI' })
