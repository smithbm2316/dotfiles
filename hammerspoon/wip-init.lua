-- hyper keys
local hyper = { 'shift', 'ctrl', 'option' }
local cmd_hyper = { 'shift', 'ctrl', 'option', 'cmd' }

-- screens
-- local screens = hs.screen.allScreens()
-- local primary_screen, other_screen = screens[1], screens[2]

hs.window.animationDuration = 0
-- hs.window.filter.forceRefreshOnSpaceChange = true

local wf = hs.window.filter.defaultCurrentSpace

---@param dir 'next'|'prev'
function focusNextOrPrev(dir)
  local windows = wf:getWindows()
  local current = hs.window.focusedWindow()

  for i, window in ipairs(windows) do
    if window:id() == current:id() then
      local windowToRaise = nil
      if dir == 'next' then
        windowToRaise = windows[i + 1]
      else
        windowToRaise = windows[i - 1]
        if windowToRaise == nil then
          windowToRaise = windows[#windows - 1]
        end
      end

      windowToRaise:raise():focus()
      break
    end
  end
  return
end

local windows = {
  next = nil,
  prev = nil,
}

local update_window_stack = function(current_win)
  print 'fired'
  local filtered_windows = wf:getWindows(hs.window.filter.sortByCreated)

  for i, window in ipairs(filtered_windows) do
    if window:id() == current_win:id() then
      windows.next = filtered_windows[i + 1] or filtered_windows[1]
      windows.prev = filtered_windows[i - 1]
        or filtered_windows[#filtered_windows]
      break
    end
  end
  return
end
update_window_stack(hs.window.focusedWindow())

wf:subscribe(hs.window.filter.windowFocused, update_window_stack, true)

for key, space in pairs {
  a = 1,
  s = 2,
  d = 3,
  f = 4,
  g = 5,
} do
  hs.hotkey.bind(hyper, key, nil, function()
    hs.window.filter.switchedToSpace(space)
    update_window_stack(hs.window.focusedWindow())
  end)
end

hs.hotkey.bind(hyper, 'j', nil, function()
  windows.next:raise():focus()
  -- focusNextOrPrev 'next'
end)
hs.hotkey.bind(hyper, 'k', nil, function()
  windows.prev:raise():focus()
  -- focusNextOrPrev 'prev'
end)
