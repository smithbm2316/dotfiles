---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require('beautiful.theme_assets')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi

local naughty = require('naughty')
local gears = require('gears')
local awful = require('awful')

local gfs = require('gears.filesystem')
local themes_path = gfs.get_themes_dir()

local theme = {}

theme.font = 'Iosevka Nerd Font Bold 12'

-- Laserwave theme
-- theme.bg_normal     = '#27212e'
-- theme.bg_focus      = '#27212e'
-- theme.bg_urgent     = '#27212e'
-- theme.bg_minimize   = '#e0dfe1'
-- theme.bg_systray    = theme.bg_focus

-- theme.fg_normal     = '#91889b'
-- theme.fg_focus      = '#eb64b9'
-- theme.fg_urgent     = '#ffe261'
-- theme.fg_minimize   = '#b381c5'

-- theme.useless_gap   = dpi(4)
-- theme.border_width  = dpi(2)
-- theme.border_normal = '#27212e'
-- theme.border_focus  = '#eb64b9'
-- theme.border_marked = '#40b4c4'

-- Tokyo Night theme
theme.bg_normal = '#24283b'
theme.bg_focus = '#24283b'
theme.bg_urgent = '#24283b'
theme.bg_minimize = '#a9b1d6'
theme.bg_systray = theme.bg_focus

theme.fg_normal = '#a9b1d6'
theme.fg_focus = '#f7768e'
theme.fg_urgent = '#9ece6a'
theme.fg_minimize = '#bb9af7'

theme.useless_gap = dpi(4)
theme.border_width = dpi(2)
theme.border_normal = '#1a1b26'
theme.border_focus = '#7aa2f7'
theme.border_marked = '#ff9e64'

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = '#ff0000'

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

-- Variables set for theming notifications:
theme.notification_font = 'Inter V:style=Medium:size=18'

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path .. 'default/submenu.png'
theme.menu_height = dpi(32)
theme.menu_width = dpi(180)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = '#cc0000'

-- Define the image to load
theme.titlebar_close_button_normal = themes_path .. 'default/titlebar/close_normal.png'
theme.titlebar_close_button_focus = themes_path .. 'default/titlebar/close_focus.png'

theme.titlebar_minimize_button_normal = themes_path .. 'default/titlebar/minimize_normal.png'
theme.titlebar_minimize_button_focus = themes_path .. 'default/titlebar/minimize_focus.png'

theme.titlebar_ontop_button_normal_inactive = themes_path .. 'default/titlebar/ontop_normal_inactive.png'
theme.titlebar_ontop_button_focus_inactive = themes_path .. 'default/titlebar/ontop_focus_inactive.png'
theme.titlebar_ontop_button_normal_active = themes_path .. 'default/titlebar/ontop_normal_active.png'
theme.titlebar_ontop_button_focus_active = themes_path .. 'default/titlebar/ontop_focus_active.png'

theme.titlebar_sticky_button_normal_inactive = themes_path .. 'default/titlebar/sticky_normal_inactive.png'
theme.titlebar_sticky_button_focus_inactive = themes_path .. 'default/titlebar/sticky_focus_inactive.png'
theme.titlebar_sticky_button_normal_active = themes_path .. 'default/titlebar/sticky_normal_active.png'
theme.titlebar_sticky_button_focus_active = themes_path .. 'default/titlebar/sticky_focus_active.png'

theme.titlebar_floating_button_normal_inactive = themes_path .. 'default/titlebar/floating_normal_inactive.png'
theme.titlebar_floating_button_focus_inactive = themes_path .. 'default/titlebar/floating_focus_inactive.png'
theme.titlebar_floating_button_normal_active = themes_path .. 'default/titlebar/floating_normal_active.png'
theme.titlebar_floating_button_focus_active = themes_path .. 'default/titlebar/floating_focus_active.png'

theme.titlebar_maximized_button_normal_inactive = themes_path .. 'default/titlebar/maximized_normal_inactive.png'
theme.titlebar_maximized_button_focus_inactive = themes_path .. 'default/titlebar/maximized_focus_inactive.png'
theme.titlebar_maximized_button_normal_active = themes_path .. 'default/titlebar/maximized_normal_active.png'
theme.titlebar_maximized_button_focus_active = themes_path .. 'default/titlebar/maximized_focus_active.png'

theme.wallpaper = function(s)
  if s.index == 1 then
    return '/home/smithbm/pictures/retrowave-landscape/retrowave47.jpg'
  else
    return '/home/smithbm/pictures/retrowave-portrait/retrowave-vertical12.jpg'
  end
end

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path .. 'default/layouts/fairhw.png'
theme.layout_fairv = themes_path .. 'default/layouts/fairvw.png'
theme.layout_floating = themes_path .. 'default/layouts/floatingw.png'
theme.layout_magnifier = themes_path .. 'default/layouts/magnifierw.png'
theme.layout_max = themes_path .. 'default/layouts/maxw.png'
theme.layout_fullscreen = themes_path .. 'default/layouts/fullscreenw.png'
theme.layout_tilebottom = themes_path .. 'default/layouts/tilebottomw.png'
theme.layout_tileleft = themes_path .. 'default/layouts/tileleftw.png'
theme.layout_tile = themes_path .. 'default/layouts/tilew.png'
theme.layout_tiletop = themes_path .. 'default/layouts/tiletopw.png'
theme.layout_spiral = themes_path .. 'default/layouts/spiralw.png'
theme.layout_dwindle = themes_path .. 'default/layouts/dwindlew.png'
theme.layout_cornernw = themes_path .. 'default/layouts/cornernww.png'
theme.layout_cornerne = themes_path .. 'default/layouts/cornernew.png'
theme.layout_cornersw = themes_path .. 'default/layouts/cornersww.png'
theme.layout_cornerse = themes_path .. 'default/layouts/cornersew.png'

-- Notification settings
-- cc: https://github.com/WillPower3309/awesome-dotfiles/blob/master/awesome/components/notifications.lua
naughty.config.defaults.ontop = true
naughty.config.defaults.font = theme.notification_font
naughty.config.defaults.icon_size = dpi(32)
naughty.config.defaults.screen = awful.screen.focused()
naughty.config.defaults.timeout = 4
naughty.config.defaults.title = 'System Notification'
naughty.config.defaults.margin = dpi(16)
naughty.config.defaults.border_width = 0
naughty.config.defaults.position = 'top_right'
naughty.config.defaults.shape = function(cr, w, h)
  gears.shape.rounded_rect(cr, w, h, dpi(6))
end

naughty.config.padding = dpi(7)
naughty.config.spacing = dpi(7)
naughty.config.icon_dirs = {
  '/usr/share/icons/Papirus',
}
naughty.config.icon_formats = { 'png', 'svg' }

-- notifications normal
naughty.config.presets.normal = {
  font = theme.notification_font,
  fg = theme.fg_normal,
  bg = theme.bg_normal,
  position = 'top-right',
}

-- notifications critical
naughty.config.presets.critical = {
  font = theme.notification_font,
  fg = theme.fg_focus,
  bg = theme.bg_normal,
  position = 'top-right',
  border_color = theme.fg_focus,
  border_width = dpi(2),
  timeout = 0,
}

-- other notifications
naughty.config.presets.low = naughty.config.presets.normal
naughty.config.presets.ok = naughty.config.presets.normal
naughty.config.presets.info = naughty.config.presets.normal
naughty.config.presets.warn = naughty.config.presets.critical
naughty.config.presets.warn.border_color = theme.fg_urgent
naughty.config.presets.warn.fg = theme.fg_urgent

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = 'Papirus'

return theme
