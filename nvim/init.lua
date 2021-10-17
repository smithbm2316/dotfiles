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
--  https://ben-smith.dev
--  This is my neovim configuration!
--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Map leader to space
vim.g.mapleader = ' '

if vim.g.vscode ~= nil then
  require('my.settings') -- my vim settings
  require('my.maps') -- my key mappings
else
  -- Autoinstall packer.nvim if not already installed
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd 'packadd packer.nvim'
  end

  require('globals') -- require all global functions before loading other stuff
  require('my.settings') -- my vim settings
  require('my.maps') -- my key mappings
  require('my.ftdetect') -- my filetype-specific settings
  require('my.user_commands') -- my custom user-defined commands
  require('utils') -- utility modules for various things
  require('my.plugins') -- my plugin loader (uses packer.nvim)
  require('my.plugs') -- my plugin-specific settings
  vim.g.rose_pine_variant = 'moon'
  vim.cmd('colorscheme rose-pine')
  nnoremap('<leader>tt', "<cmd>lua require'rose-pine.functions'.toggle_variant { 'moon', 'dawn' }<cr>")
end
