-- Clear old highlights
local utils = {}

function utils.clear()
 vim.cmd('hi clear')
end

function utils.set_namespace(ns_name)
  -- Color namespace
  local ns = vim.api.nvim_create_namespace(ns_name)

  -- Activate namespace

  -- This API isn't stable yet. It will receive breaking changes
  -- and be renamed to nvim_set_hl_ns later be aware of that.
  -- for more details https://github.com/neovim/neovim/issues/14090#issuecomment-799285918
  vim.api.nvim__set_hl_ns(ns)
  return ns
end
return utils
