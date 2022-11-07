local ok, notifier = pcall(require, 'notifier')
if not ok then
  return
end

notifier.setup {
  -- Ignore message from LSP servers with this name
  ignore_messages = {},
  -- set width
  status_width = function()
    local cols = vim.o.columns
    if cols > 120 then
      return math.floor(cols / 4)
    else
      return math.floor(cols / 3)
    end
  end,
  -- Order of the components to draw from top to bottom (first nvim notifications, then lsp)
  components = {
    -- Nvim notifications (vim.notify and such)
    'nvim',
    -- LSP status updates
    'lsp',
  },
  notify = {
    -- Time in milliseconds before removing a vim.notify notification, 0 to make them sticky
    clear_time = 3000,
    -- Minimum log level to print the notification
    min_level = vim.log.levels.INFO,
  },
  -- Whether to prefix the title of the notification by the component name
  component_name_recall = false,
  -- The zindex to use for the floating window. Note that changing this value may cause visual bugs with other windows overlapping the notifier window.
  zindex = 50,
}
