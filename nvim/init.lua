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
--  This is my neovim configuration!
--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- aliases
local fn = vim.fn
local cmd = vim.cmd

-- Set my leader key to space
vim.g.mapleader = ' '

if vim.g.vscode then
  require('globals') -- require all global functions before loading other stuff
  require('my.settings') -- my vim settings
  require('my.maps') -- my key mappings
  cmd 'runtime! vimscript/**' -- load all vimscript files
else
  -- Autoinstall packer.nvim if not already installed
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd 'packadd packer.nvim'
  end

  -- Load my configuration files
  require('globals') -- require all global functions before loading other stuff
  require('my.settings') -- my vim settings
  cmd 'runtime! vimscript/**' -- load all vimscript files
  require('my.maps') -- my key mappings
  require('my.ftdetect') -- my filetype-specific settings
  require('utils') -- utility modules for various things
  require('my.plugins') -- my plugin loader (uses packer.nvim)
  require('my.plugs') -- my plugin-specific settings
  vim.g.rose_pine_variant = 'moon'
  cmd 'colorscheme rose-pine'
end
