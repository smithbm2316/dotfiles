import os
import re
import subprocess

from libqtile import bar, hook, layout, widget
from libqtile.config import Click, Drag, DropDown, Group, Key, Match, ScratchPad, Screen
from libqtile.lazy import lazy

mod = 'mod4'
ctrl = 'control'
alt = 'mod1'
shift = 'shift'

terminal = 'kitty'
dotfiles = os.path.expanduser('~/dotfiles')

keys = [
  # A list of available commands that can be bound to keys can be found
  # at https://docs.qtile.org/en/latest/manual/config/lazy.html
  # Switch between windows
  Key([mod], 'h', lazy.layout.left(), desc='Move focus to left'),
  Key([mod], 'l', lazy.layout.right(), desc='Move focus to right'),
  Key([mod], 'j', lazy.layout.down(), desc='Move focus down'),
  Key([mod], 'k', lazy.layout.up(), desc='Move focus up'),
  # Move windows between left/right columns or move up/down in current stack.
  # Moving out of range in Columns layout will create new column.
  Key([mod, ctrl], 'h', lazy.layout.shuffle_left(), desc='Move window to the left'),
  Key([mod, ctrl], 'l', lazy.layout.shuffle_right(), desc='Move window to the right'),
  Key([mod, ctrl], 'j', lazy.layout.shuffle_down(), desc='Move window down'),
  Key([mod, ctrl], 'k', lazy.layout.shuffle_up(), desc='Move window up'),
  # Grow windows. If current window is on the edge of screen and direction
  # will be to screen edge - window would shrink.
  # Key([mod, shift], 'h', lazy.layout.grow_left(), desc='Grow window to the left'),
  # Key([mod, shift], 'l', lazy.layout.grow_right(), desc='Grow window to the right'),
  # Key([mod, shift], 'j', lazy.layout.grow_down(), desc='Grow window down'),
  # Key([mod, shift], 'k', lazy.layout.grow_up(), desc='Grow window up'),
  Key([mod, shift], 'k', lazy.layout.shrink_main(), desc='Shrink main pane'),
  Key([mod, shift], 'j', lazy.layout.grow_main(), desc='Grow main pane'),
  # next/prev group
  Key([mod], 'semicolon', lazy.screen.next_group(), desc='Go to next group'),
  Key([mod], 'comma', lazy.screen.prev_group(), desc='Go to prev group'),
  Key([mod], 'i', lazy.screen.toggle_group(), desc='Go to last group'),
  # various layout keybinds
  Key(
    [mod],
    'space',
    lazy.window.toggle_floating(),
    desc='Toggle a window between tiled and floating'
  ),
  # Key([mod], 'n', lazy.layout.next(), desc='Move window focus to other window'),
  Key([mod], 'w', lazy.next_layout(), desc='Toggle between layouts'),
  Key([mod, ctrl], 'w', lazy.layout.normalize(), desc='Reset all window sizes'),
  # terminal
  Key([mod], 't', lazy.spawn(terminal), desc='Launch terminal'),
  Key([mod], 'c', lazy.window.kill(), desc='Kill focused window'),
  Key([mod, ctrl], 'r', lazy.reload_config(), desc='Reload the config'),
  Key([mod, ctrl], 'q', lazy.shutdown(), desc='Shutdown Qtile'),
  # rofi scripts
  Key([mod], 'r', lazy.spawncmd(), desc='Spawn a command using a prompt widget'),
  Key([mod], 'o', lazy.spawn(f'{dotfiles}/rofi/rofi.sh drun'), desc='Rofi drun'),
  Key([mod], 'e', lazy.spawn(f'{dotfiles}/rofi/rofi.sh run'), desc='Rofi run'),
  Key([alt], 'Tab', lazy.spawn(f'{dotfiles}/rofi/rofi.sh window'), desc='Rofi window'),
  Key([mod], 'q', lazy.spawn(f'{dotfiles}/rofi/rofi.sh calc'), desc='Rofi qalc'),
  Key([mod, ctrl], 'e', lazy.spawn(f'{dotfiles}/rofi/rofi.sh emoji'), desc='Rofi emoji'),
  Key([mod], 'slash', lazy.spawn(f'{dotfiles}/rofi/powermenu.sh'), desc='Rofi powermenu'),
  # audio
  Key(
    [],
    'XF86AudioRaiseVolume',
    lazy.spawn('pactl set-sink-volume @DEFAULT_SINK@ +5%'),
    desc='Volume up'
  ),
  Key(
    [],
    'XF86AudioLowerVolume',
    lazy.spawn('pactl set-sink-volume @DEFAULT_SINK@ -5%'),
    desc='Volume down'
  ),
  Key(
    [],
    'XF86AudioMute',
    lazy.spawn('pactl set-sink-mute @DEFAULT_SINK@ toggle'),
    desc='Toggle mute'
  ),
  Key(
    [mod],
    'XF86AudioMute',
    lazy.spawn(f'{dotfiles}/scripts/mute-mic-toggle.sh'),
    desc='Toggle mic mute'
  ),
  Key([], 'XF86AudioPlay', lazy.spawn('playerctl play-pause'), desc='Toggle play/pause'),
  Key([], 'XF86AudioPrev', lazy.spawn('playerctl previous'), desc='Previous track'),
  Key([], 'XF86AudioNext', lazy.spawn('playerctl next'), desc='Next track'),
  # warpd
  Key([mod, shift], 'm', lazy.spawn('warpd --grid'), desc='Launch warpd --hint'),
  Key([mod], 'm', lazy.spawn('warpd --hint'), desc='Launch warpd --normal'),
  Key([mod, ctrl], 'm', lazy.spawn('warpd --normal'), desc='Launch warpd --grid'),
  # screenshots
  Key([], 'Print', lazy.spawn('flameshot gui -c -s'), desc='Screenshot to clipboard'),
  Key([mod, ctrl], 'Print', lazy.spawn('flameshot gui'), desc='Screenshot gui'),
  Key(
    [mod],
    'Print',
    lazy.spawn('flameshot screen --clipboard'),
    desc='Screenshot screen to clipboard'
  ),
  # watch video in mpv
  Key([mod], 'y', lazy.spawn(f'{dotfiles}/scripts/watch-video.sh'), desc='Watch video in mpv'),
  # misc
  Key(
    [mod],
    'F10',
    lazy.spawn(f'{dotfiles}/scripts/toggle-touchpad-dir.sh'),
    desc='Toggle touchpad direction'
  ),
  Key(
    [mod],
    'F11',
    lazy.spawn(f'{dotfiles}/scripts/toggle-laptop-keyboard.sh'),
    desc='Toggle laptop keyboard'
  ),
  Key(
    [mod, alt], 'a', lazy.spawn(f'{dotfiles}/scripts/airpods.sh connection'), desc='Toggle airpods connection'
  ),
  Key(
    [mod, alt], 'm', lazy.spawn(f'{dotfiles}/scripts/airpods.sh codec'), desc='Toggle airpods mic on/off (codec)'
  ),
  Key(
    [mod, ctrl], 'i', lazy.spawn(f'{os.path.expanduser("~/.local/bin/")}/sys-theme'), desc='Toggle system theme between light and dark'
  ),
  Key(
    [mod, alt], 'x', lazy.spawn('xrandr --auto'), desc='Run xrandr in auto mode'
  ),
  Key(
    [mod], 'F9', lazy.spawn('xrandr --output eDP-1 --mode 1920x1080 --rate 144.03 --pos 1920x0'), desc='Turn on internal laptop display'
  ),
  Key(
    [mod, shift], 'F9', lazy.spawn('xrandr --output eDP-1 --off'), desc='Turn off internal laptop display'
  ),
  Key(
    [],
    'XF86TouchpadToggle',
    lazy.spawn(f'{dotfiles}/scripts/toggle-touchpad-enabled.sh'),
    desc='Toggle touchpad enabled'
  ),
  Key(
    [mod],
    'b',
    lazy.spawn(f'kitty --session {dotfiles}/kitty/sessions/buku.conf'),
    desc='Buku add bookmark'
  ),
  Key(
    [mod, ctrl],
    'v',
    lazy.spawn(f'kitty --session {dotfiles}/kitty/sessions/mtg.conf'),
    desc='Launch mtg video cmd'
  ),
]

groups = [
  Group(name=key, label=config['label'], matches=config['apps']) for key, config in {
    'a': {
      'label': 'dev',
      'apps': [
        Match(wm_class='brave-browser'),
        Match(wm_class='kitty', title='dev'),
        Match(wm_class='1password'),
      ],
    },
    's': {
      'label': 'web',
      'apps': [
        Match(wm_class='firefox'),
      ]
    },
    'd': {
      'label': 'msg',
      'apps': [
        Match(wm_class='slack'),
        Match(wm_class='discord'),
      ]
    },
    'f': {
      'label': 'misc',
      'apps': [
        Match(wm_class='spotify'),
        Match(wm_class='ncspot'),
        Match(wm_class='obs'),
      ]
    },
    'g': {
      'label': 'note',
      'apps': [
        Match(wm_class='obsidian'),
        Match(wm_class='standard notes'),
      ]
    },
    'n': {
      'label': 'sec',
      'apps': [],
    },
  }.items()
]

for index, group in enumerate(groups):
  keys.extend(
    [
      # mod1 + letter of group = switch to group
      Key(
        [mod],
        group.name,
        lazy.group[group.name].toscreen(),
        desc=f'Switch to group {index}:{group.name}',
      ),
      # mod1 + index of group = switch to group
      Key(
        [mod],
        str(index + 1),
        lazy.group[group.name].toscreen(),
        desc=f'Switch to group {index}:{group.name}',
      ),
      # mod1 + ctrl + letter of group = switch to & move focused window to group
      Key(
        [mod, ctrl],
        group.name,
        lazy.window.togroup(group.name, switch_group=True),
        desc=f'Switch to & move focused window to group {index}:{group.name}',
      ),
      # mod1 + ctrl + index of group = switch to & move focused window to group
      Key(
        [mod, ctrl],
        str(index + 1),
        lazy.window.togroup(group.name, switch_group=True),
        desc=f'Switch to & move focused window to group {index}:{group.name}',
      ),
    ]
  )

# set up scratchpad
groups.extend(
  [
    ScratchPad(
      'scratchpad',
      [
        # define a drop down terminal.
        # it is placed in the upper third of screen by default.
        DropDown(
          'terminal',
          f'{terminal} --title=scratchpad',
          # not sure why but this throws an error in pyright
          height=0.5,  # type: ignore
          on_focus_lost_hide=False,  # type: ignore
          opacity=1.0,  # type: ignore
          width=0.4,  # type: ignore
          x=0.3,  # type: ignore
          y=0.25,  # type: ignore
        ),
      ],
      single=True,
    ),
  ]
)

# and set the keybinding for the scratchpad
keys.extend([
  Key([mod, ctrl], 't', lazy.group['scratchpad'].dropdown_toggle('terminal')),
])

layouts = [
  # layout.Bsp(), # type: ignore
  # layout.Matrix(), # type: ignore
  layout.Max(),  # type: ignore
  # layout.Columns(), # type: ignore
  layout.MonadTall(),  # type: ignore
  # layout.MonadThreeCol(), # type: ignore
  # layout.MonadWide(), # type: ignore
  # layout.RatioTile(), # type: ignore
  # layout.Slice(), # type: ignore
  # layout.Spiral(), # type: ignore
  # layout.Stack(num_stacks=2), # type: ignore
  # layout.Tile(), # type: ignore
  # layout.TreeTab(), # type: ignore
  # layout.VerticalTile(), # type: ignore
  # layout.Zoomy(), # type: ignore
]

widget_defaults = dict(
  font='BlexMono Nerd Font Mono Medium',
  fontsize=14,
  padding=4,
)
extension_defaults = widget_defaults.copy()

screens = [
  Screen(
    top=bar.Bar(
      [
        widget.CurrentLayoutIcon(scale=0.69),
        widget.Chord(
          chords_colors={
            'launch': ('#232126', '#e0def4'),
          },
          name_transform=lambda name: name.upper(),
        ),
        widget.GroupBox(
          active='#e0def4',
          block_highlight_text_color='#232126',
          foreground='#e0def4',
          inactive='#817c9c',
          highlight_method='block',
          margin=3,
          padding=5,
          markup=True,
          rounded=True,
          this_current_screen_border='#9ccfd8',
          urgent_border=None,
          urgent_text='#f6c177',
          use_mouse_wheel=False,
        ),
        widget.TaskList(
          border='#3e8fb0',
          highlight_method='block',
          parse_text=lambda _: '',
          padding_x=0,
          theme_mode='fallback',
          theme_path='/usr/share/icons/Papirus-Dark',
          rounded=True,
          urgent_alert_method='border',
          urgent_border='#f6c177',
        ),
        widget.Prompt(),
        # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
        # widget.StatusNotifier(),
        widget.Spacer(),
        widget.Pomodoro(
          color_active='#eb6f92',
          color_break='#3e8fb0',
          color_inactive='#e0def4',
          foreground='#e0def4',
          fontsize=16,
          length_short_break=5,
          length_long_break=15,
          length_pomodori=45,
          notification_on=True,
          num_pomodori=4,
          padding_x=4,
          prefix_active=' ',
          prefix_break=' ',
          prefix_inactive='',
          prefix_paused=' ',
          prefix_long_break=' ',
        ),
        widget.CPU(
          foreground='#3e8fb0',
          fmt=' {}',
        ),
        widget.ThermalZone(
          crit=80,
          fgcolor_crit='#eb6f92',
          fgcolor_high='#f6c177',
          fgcolor_normal='#3e8fb0',
          foreground='#e0def4',
          format_crit='{temp}°C',
          high=60,
        ),
        widget.Memory(
          foreground='#ea9a97',
          measure_mem='G',
          fmt=' {}',
        ),
        widget.Volume(
          device='default',
          emoji=False,
          fmt='♪ {}',
          # get_volume_command = "pactl get-sink-volume @DEFAULT_SINK@ | sed -nr 's/^.* ([0-9]+)%.*$/\1/p'",
          mute_command='pactl set-sink-mute @DEFAULT_SINK@ toggle',
          volume_app=None,
          volume_down_command='pactl set-sink-volume @DEFAULT_SINK@ -5%',
          volume_up_command='pactl set-sink-volume @DEFAULT_SINK@ +5%',
        ),
        widget.Battery(
          battery=0,
          charge_char='',
          discharge_char='',
          empty_char='',
          foreground='#9ccfd8',
          format='{char} {percent:2.0%}',
          full_char='',
          low_foreground='#eb6f92',
          low_percentage=0.2,
          notification_timeout=5,
          notify_below=0.2,
          unknown_char='',
        ),
        widget.Clock(
          foreground='#c4a7e7',
          format='  %a %b %d, %I:%M%P',
        ),
        widget.Systray(),
        # widget.QuickExit(),
      ],
      32,
      background='#232126',
      border_color='#232126',  # or a list of [N, E, S, W] border hex colors
      border_width=0,  # or a list of [N, E, S, W] border widths
      margin=0,
      opacity=1,
    ),
  ),
]

# Drag floating layouts.
mouse = [
  Drag([mod], 'Button1', lazy.window.set_position_floating(), start=lazy.window.get_position()),
  Drag([mod], 'Button3', lazy.window.set_size_floating(), start=lazy.window.get_size()),
  Click([mod], 'Button2', lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating( # type: ignore
  # Run the utility of `xprop` to see the wm class and name of an X client.
  float_rules=[
    # include qtile's defaults
    *layout.Floating.default_float_rules, # type: ignore
    Match(wm_class='blueman-manager'),
    Match(wm_class='pavucontrol'),
    Match(wm_class=re.compile(r'zoom\s?').pattern),
    Match(wm_class='kit'),
    Match(wm_class='simplescreenrecorder'),
  ],
)
auto_fullscreen = False
focus_on_window_activation = 'smart'
reconfigure_screens = False

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = False

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = 'LG3D'


@hook.subscribe.startup_once
def autostart():
  autostart_path = os.path.expanduser('~/dotfiles/qtile/autostart.sh')
  subprocess.Popen([autostart_path])
