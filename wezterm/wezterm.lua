local wezterm = require 'wezterm'

return {
  font = wezterm.font_with_fallback {
    { family = 'IBM Plex Mono', weight = 'Medium' },
    'Symbols Nerd Font Mono',
  },
  font_size = 12.0,
  font_shaper = 'Harfbuzz',
  line_height = 1.2,
  hide_tab_bar_if_only_one_tab = true,
  -- ensures that tmux-copy mode works properly, saves selection to system clipboard
  term = 'wezterm',
  window_close_confirmation = 'NeverPrompt',
  window_decorations = 'TITLE | RESIZE',
  window_padding = {
    left = 6,
    right = 6,
    top = 6,
    bottom = 6,
  },
  text_background_opacity = 1.0,
  window_background_opacity = 1.0,
  color_schemes = {
    ['Rose Pine Moon'] = {
      -- The default text color
      foreground = '#e0def4',
      -- The default background color
      background = '#232136',

      -- Overrides the cell background color when the current cell is occupied by the
      -- cursor and the cursor style is set to Block
      cursor_bg = '#59546d',
      -- Overrides the text color when the current cell is occupied by the cursor
      cursor_fg = '#e0def4',
      -- Specifies the border color of the cursor when the cursor style is set to Block,
      -- or the color of the vertical or horizontal bar when the cursor style is set to
      -- Bar or Underline.
      cursor_border = '#c4a7e7',

      -- the foreground color of selected text
      selection_fg = '#e0def4',
      -- the background color of selected text
      selection_bg = '#312f44',

      -- The color of the scrollbar "thumb"; the portion that represents the current viewport
      scrollbar_thumb = '#c4a7e7',

      -- The color of the split lines between panes
      split = '#3e8fb0',

      ansi = { '#393552', '#eb6f92', '#3e8fb0', '#f6c177', '#9ccfd8', '#c4a7e7', '#ea9a97', '#e0def4' },
      brights = { '#817c9c', '#eb6f92', '#3e8fb0', '#f6c177', '#9ccfd8', '#c4a7e7', '#ea9a97', '#e0def4' },

      -- Arbitrary colors of the palette in the range from 16 to 255
      -- indexed = { [136] = '#af8700' },

      -- Since: 20220319-142410-0fcdea07
      -- When the IME, a dead key or a leader key are being processed and are effectively
      -- holding input pending the result of input composition, change the cursor
      -- to this color to give a visual cue about the compose state.
      compose_cursor = '#ea9a97',
    },
    ['Rose Pine'] = {
      -- The default text color
      foreground = '#e0def4',
      -- The default background color
      background = '#191724',

      -- Overrides the cell background color when the current cell is occupied by the
      -- cursor and the cursor style is set to Block
      cursor_bg = '#555169',
      -- Overrides the text color when the current cell is occupied by the cursor
      cursor_fg = '#e0def4',
      -- Specifies the border color of the cursor when the cursor style is set to Block,
      -- or the color of the vertical or horizontal bar when the cursor style is set to
      -- Bar or Underline.
      cursor_border = '#c4a7e7',

      -- the foreground color of selected text
      selection_fg = '#e0def4',
      -- the background color of selected text
      selection_bg = '#2a2837',

      -- The color of the scrollbar "thumb"; the portion that represents the current viewport
      scrollbar_thumb = '#c4a7e7',

      -- The color of the split lines between panes
      split = '#3e8fb0',

      ansi = { '#26233a', '#eb6f92', '#31748f', '#f6c177', '#9ccfd8', '#c4a7e7', '#ebbcba', '#e0def4' },
      brights = { '#6e6a86', '#eb6f92', '#31748f', '#f6c177', '#9ccfd8', '#c4a7e7', '#ebbcba', '#e0def4' },

      -- Arbitrary colors of the palette in the range from 16 to 255
      -- indexed = { [136] = '#af8700' },

      -- Since: 20220319-142410-0fcdea07
      -- When the IME, a dead key or a leader key are being processed and are effectively
      -- holding input pending the result of input composition, change the cursor
      -- to this color to give a visual cue about the compose state.
      compose_cursor = '#ebbcba',
    },
  },
  color_scheme = 'Rose Pine Moon',
  --[[ unix_domains = {
    {
      name = 'mux',
      serve_command = { 'wezterm-mux-server', '--daemonize' },
    },
  }, ]]
  ssh_domains = {
    {
      -- This name identifies the domain
      name = 'hunk-of-junk',
      -- The hostname or address to connect to. Will be used to match settings
      -- from your ssh config file
      remote_address = 'hunk-of-junk.local',
      -- The username to use on the remote host
      username = 'smithbm',
    },
  },
}
