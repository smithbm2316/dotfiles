-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--
--  ███████╗███╗   ███╗██╗████████╗██╗  ██╗██████╗ ███╗   ███╗██████╗ ██████╗  ██╗ ██████╗
--  ██╔════╝████╗ ████║██║╚══██╔══╝██║  ██║██╔══██╗████╗ ████║╚════██╗╚════██╗███║██╔════╝
--  ███████╗██╔████╔██║██║   ██║   ███████║██████╔╝██╔████╔██║ █████╔╝ █████╔╝╚██║███████╗
--  ╚════██║██║╚██╔╝██║██║   ██║   ██╔══██║██╔══██╗██║╚██╔╝██║██╔═══╝  ╚═══██╗ ██║██╔═══██╗
--  ███████║██║ ╚═╝ ██║██║   ██║   ██║  ██║██████╔╝██║ ╚═╝ ██║███████╗██████╔╝ ██║╚██████╔╝
--  ╚══════╝╚═╝     ╚═╝╚═╝   ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚═╝     ╚═╝╚══════╝╚═════╝  ╚═╝ ╚═════╝
--
--  Ben Smith
--  github.com/smithbm2316
--  https://ben-smith.dev
--  This is neovim configuration!
--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set leader key to space
vim.g.mapleader = ' '

-- if we are using VSCode, only load certain files
if vim.g.vscode then
  require 'globals'
  require 'bs'
  require 'maps'
else
  -- settings for neovide gui
  if vim.g.neovide then
    vim.cmd [[set guifont=JetBrains\ Mono:h13.1]]
    vim.g.neovide_scale_factor = 1.0
    vim.g.neovide_refresh_rate = 144
    vim.g.neovide_confirm_quit = true
    vim.g.neovide_remember_window_size = true
  end

  -- Autoinstall packer.nvim if not already installed
  local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd 'packadd packer.nvim'
  end

  -- load impatient.nvim and compiled packer output before everything else
  local impatient_ok, impatient = pcall(require, 'impatient')
  if impatient_ok then
    impatient.enable_profile()
  else
    print "couldn't load impatient.nvim"
  end

  local packer_compiled_ok = pcall(require, 'packer/packer_compiled')
  if packer_compiled_ok then
    require 'packer/packer_compiled'
  end

  -- load my vim settings
  require 'settings'

  -- load my global helpers and wrappers
  require 'globals'

  -- load my personal variables, settings, and functions
  require 'bs'

  -- load my keymappings
  require 'maps'

  -- load my user commands
  require 'user_commands'

  -- load my ftdetect settings
  require 'ftdetect'

  -- load various utility functions
  require 'utils'

  -- load all of my packer plugins
  require 'install_plugins'

  -- load all of my plugin config files
  require 'plugins'
end
