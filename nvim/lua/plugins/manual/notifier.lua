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
  components = nil,
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

-- override default vim.notify behavior with plugin
-- auto-convert tables to string interpretation so we can print it
vim.notify = function(msg, log_level, opts)
  if type(msg) == 'table' then
    msg = vim.inspect(msg)
  elseif type(msg) == 'number' or type(msg) == 'boolean' then
    msg = tostring(msg)
  elseif type(msg) == 'string' then
    -- ignore the LSP warning for no matching language servers to format with
    if msg == '[LSP] Format request failed, no matching language servers.' then
      return
    end
  else
    notifier.notify([[Could'nt convert value to a string]], vim.log.levels.ERROR, opts)
    return
  end

  notifier.notify(msg, log_level, opts)
end
