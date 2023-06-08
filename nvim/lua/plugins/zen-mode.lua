local ok, zen_mode = pcall(require, 'zen-mode')
if not ok then
  return
end

zen_mode.setup {
  window = {
    width = 100,
    backdrop = 0.95,
  },
  -- callback where you can add custom code when the Zen window opens
  on_open = function()
    local has_focus, focus = pcall(require, 'focus')
    if has_focus then
      focus.focus_disable()
    end
  end,
  -- callback where you can add custom code when the Zen window closes
  on_close = function()
    local has_focus, focus = pcall(require, 'focus')
    if has_focus then
      focus.focus_enable()
    end
  end,
}

nnoremap('<leader>tz', '<cmd>ZenMode<cr>', 'Toggle zen mode')
