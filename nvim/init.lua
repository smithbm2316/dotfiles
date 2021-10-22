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

if vim.g.vscode then
  require('globals') -- require all global functions before loading other stuff
  require('settings') -- my vim settings
  require('maps') -- my key mappings
  cmd 'runtime! vimscript/**' -- load all vimscript files
else
  -- Autoinstall packer.nvim if not already installed
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd 'packadd packer.nvim'
  end

  -- Load configuration files
  require('globals') -- require all global functions before loading other stuff
  require('settings') -- my vim settings
  cmd 'runtime! vimscript/**' -- load all vimscript files
  require('maps') -- my key mappings
  require('ftdetect') -- my filetype-specific settings
  require('utils') -- utility modules for various things
  require('install_plugins') -- my plugin loader (uses packer.nvim)
  vim.g.rose_pine_variant = 'moon'
  cmd 'colorscheme rose-pine'
  require('plugins') -- my plugin-specific settings
end
