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
-- aliases
local fn = vim.fn
local cmd = vim.cmd

-- Set leader key to space
vim.g.mapleader = ' '

-- if we are using VSCode, only load certain files
if vim.g.vscode then
  require 'bs'
  require 'globals'
  require 'settings'
  require 'maps'
  cmd 'runtime! vimscript/**' -- load all vimscript files
else
  -- Autoinstall packer.nvim if not already installed
  local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd 'packadd packer.nvim'
  end

  -- load my personal variables, settings, and functions
  require 'bs'

  -- load my global helpers
  require 'globals'

  -- load my vim settings
  require 'settings'

  -- load any vimscript files I have in ~/.config/nvim/vimscript
  cmd 'runtime! vimscript/**' -- load all vimscript files

  -- load my keymappings
  require 'maps'

  -- load my ftdetect settings
  require 'ftdetect'

  -- load various utility functions
  require 'utils'

  -- load all of my packer plugins
  require 'install_plugins'

  -- load all of my plugin config files
  require 'plugins'

  -- set my colorscheme to the correct variant depending on whether it's between 9am-5pm or not
  -- local current_hour = tonumber(vim.fn.strftime '%H')
  -- local color_mode = current_hour > 9 and current_hour < (12 + 4) and 'light' or 'dark'
end
