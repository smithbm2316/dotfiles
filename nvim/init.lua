--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
--  ben-smith.dev/
--  This is my neovim configuration!
--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Map leader to space
vim.g.mapleader = ' '

-- Autoinstall packer.nvim if not already installed
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_command.execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  vim.api.nvim_command.execute 'packadd packer.nvim'
end

-- vim.cmd('colorscheme laserwave')
require('my.plugins') -- my plugin loader (uses packer.nvim)
require('my.settings') -- my vim settings
require('my.plugconfigs') -- my plugin-specific settings
require('my.maps') -- my key mappings
-- require('my.statusline') -- my statusline
require('utils') -- utility modules for various things

vim.cmd [[ autocmd! BufRead,BufNewFile *.conf,config,.ini setf dosini ]]
