# ENVIRONMENT VARIABLES
# xdg variables
$XDG_CACHE_HOME="$HOME/.cache"
$XDG_CONFIG_HOME="$HOME/.config"
$XDG_DATA_HOME="$HOME/.local/share"

# xonsh variables
$AUTO_CD = 1
$HISTSIZE = "10000"
$PROMPT = "{cwd_base} {prompt_end} "
$RIGHT_PROMPT = " {gitstatus}"
$SAVEHIST = "10000"
$VI_MODE = 1
$XONSH_DATETIME_FORMAT = "%m-%d-%Y %H:%M"

# path variables

$CARGOBIN = "$HOME/.cargo/bin"
$GOEXEC = "/usr/local/go/bin"
$GOBIN = "$HOME/code/go/bin"
$GOPATH = "$HOME/code/go"
$YARNBIN = "$HOME/.yarn/bin"

# environment variables
$COLORTERM = "truecolor"
$EDITOR = "nvim"
$FZF_DEFAULT_COMMAND = "rg --files ."
$LOCALBIN = "$HOME/.local/bin"
$MANPAGER = "nvim -c \'set ft=man\' -"
$NEXT_TELEMETRY_DISABLED = "1"
$RANGER_LOAD_DEFAULT_RC = "FALSE"
$VISUAL = "nvim"
$ZDOTDIR = "$HOME/.config/zsh"

# os-specific settings
if $(uname -s) == "Linux":
  # setup keychain settings
  keychain --eval --quiet id_ed25519_gh id_ed25519_gl

  # if on a debian-based system, write aliases for programs that
  # have debian package name conflicts
  if !(test -f "/etc/debian_version"):
    aliases["bat"] = "batcat"
    aliases["fd"] = "fdfind"
    aliases["cal"] = "ncal -b"

    # apt update/upgrade shortcut
    def _aptup(args):
      sudo apt update
      apt list --upgradeable | rg --color=never -o '^[A-Za-z0-9-_.]*' | sed ':a;$!N;s/\n/, /;ta;P;D' -
      if len(args) > 0:
        sudo apt upgrade
    aliases["aptup"] = _aptup

elif $(uname -s) == "Darwin":
  # setup keychain settings
  keychain --eval --quiet id_rsa id_rsa_gl

# ALIASES
# navigation/file movement shortcuts
aliases["..."] = "../../"
aliases["...."] = "../../../"
aliases["....."] = "../../../../"
aliases["......"] = "../../../../../"
aliases["......."] = "../../../../../../"
aliases["........"] = "../../../../../../../"
aliases["........."] = "../../../../../../../../"
aliases["yeet"] = "rm -rf"
aliases["mv"] = "mv -iv"
aliases["cp"] = "cp -iv"
aliases["mkdir"] = "mkdir -pv"
aliases["take"] = lambda args: execx(f'mkdir {repr(args[0])} && cd {repr(args[0])}')

# browser-sync default
aliases["bsync"] = "browser-sync start --server --files '*.css, *.html, *.js' --no-open"

# lsd aliases
aliases["ls"] = "lsd"
aliases["lsa"] = "lsd -A"
aliases["l"] = "lsd -lA"
aliases["ll"] = "lsd -l"
aliases["tree"] = "ls --tree -I 'node_modules'"

# dotfile shortcuts
# TODO: add fzf menu for fuzzy searching through common config files
aliases["dots"] = "cd ~/dotfiles"
aliases["i3c"] = "nvim ~/dotfiles/i3dotfiles +'cd ~/dotfiles/i3'"
aliases["alac"] = "nvim ~/dotfiles/alacritty/alacritty.yml"
aliases["awmc"] = "nvim ~/dotfiles/awesome/rc.lua +'cd ~/dotfiles/awesome'"
aliases["kitc"] = "nvim ~/dotfiles/kitty/kitty.conf  +'cd ~/dotfiles/kitty'"
aliases["tmc"] = "nvim ~/dotfiles/tmux/tmux.conf"
aliases["vimc"] = "nvim ~/dotfiles/.vimrc"
aliases["xinc"] = "nvim ~/dotfiles/x11/xinitrc"
aliases["xmob"] = "nvim ~/dotfiles/xmonad/xmobar0.hs +'cd ~/dotfiles/xmonad'"
aliases["xmoc"] = "nvim ~/dotfiles/xmonad/xmonad.hs +'cd ~/dotfiles/xmonad'"

# neovim aliases 
aliases["nvpack"] = "cd ~/.local/share/nvim/site/pack/packer/start"
aliases["nvs"] = "nvim -S"

def _nv(args):
  if len(args) == 0:
    nvim
  else:
    file_dir_to_open = ""
    if args[0] == "plug":
      file_dir_to_open = "plugins.lua"
    elif args[0] == "plugs":
      file_dir_to_open = "plugconfigs"
    elif args[0] == "maps":
      file_dir_to_open = "maps.lua"
    elif args[0] == "sets":
      file_dir_to_open = "settings.lua"
    else
      nvim @(args)
      return
    nvim @(f"~/.config/nvim/lua/my/{file_dir_to_open} -c 'cd ~/.config/nvim'")
aliases["nv"] = _nv

# pandoc aliases
aliases["pandocHardBreak"] = lambda args: execx(f'pandoc {repr(args[0])} --from markdown+hard_line_breaks -o {repr(args[1])}')

# tmux aliases
aliases["tmls"] = "tmux list-sessions"

# tmux attach to most recent or specified session
def _tma(args):
  if [ -z $@ ]; then
    tmux attach
  else
    tmux attach -t $@
  fi
aliases["tma"] = _tma

# tmux kill-server or kill-session specified
def _tmks(args):
  if len(args) == 0:
    tmux kill-server
  else:
    tmux kill-session -t args[0]
aliases["tmks"] = _tmks

# tmux new session command
def _tmn(args):
  tmux new-session -s args
aliases["tmn"] = _tmn

# tmux new project command
def _tmnp(args):
  tmux \
    new -c args[1] -n code -s args[0] \; \
    send 'nvim' C-m \; \
    neww -c args[1] -n serve \; \
    splitw -h -c args[1] -t serve \; \
    send 'js dev' C-m
aliases["tmnp"] = _tmnp

# short command for dumping links quickly and easily
def _dump(args):
  if len(args) == 0:
    ls ~/code/braindump | sed -n "s/.md/ /p" - | paste -sd ' ' -
    echo -n "Dump to file: "
    read dumpfile
    echo -n "Link: "
    read link
    echo -n "Title: "
    read title
    echo "- [$title]($link)" >> ~/code/braindump/$dumpfile.md
    echo "Dumped successfully! Get back to work punk!"
  elif args[0] == "r":
    files="$(ls ~/code/braindump | sed -n "s/.md/ /p" - | paste -sd ' ' -)"
    echo -n "Dump all to same file? (y/n): "
    read samefile
    dumpfile=""

    loop_index = 1
    while loop_index > 0:
      if samefile == "n" or loop_index == 1:
        echo $files
        echo -n "Dump to file: "
        read dumpfile
        loop_index += 1
      echo -n "Link: "
      read link

      if link == "done":
        break

      echo -n "Title: "
      read title
      echo "- [$title]($link)" >> ~/code/braindump/$dumpfile.md
      echo "Dumped successfully, onto the next link!"
    done
  elif args[0] == "o":
    ls ~/code/braindump | sed -n "s/.md/ /p" - | paste -sd ' ' -
    echo -n "Which file to open: "
    read dumpfile
    nvim ~/code/braindump/$dumpfile.md -c "cd ~/code/braindump"
  else
    echo "Choose a valid option: no args, (o)pen, (r)epeat"
aliases["dump"] = _dump

# xonsh reload rc.xsh config
aliases["sosh"] = "source ~/dotfiles/xonsh/rc.xsh"

# create a virtual camera for OBS to use
aliases["vcam"] = "sudo modprobe v4l2loopback video_nr=7 card_label='OBS Virtual Cam'"

# yarn and npm shortcut
def _js(args):
  if !(test -f "package-lock.json"):
    npm run args
  elif !(test -f "yarn.lock"):
    yarn run args
  else
    print("No npm or yarn project found")
  fi
aliases["js"] = _js

# I HAVE THE POWER, YOU OBEY ME COMPUTER
def _iamroot():
  prevcmd=$(fc -ln -1)
  su -c prevcmd
aliases["iamroot"] = _iamroot

# xontrib modules
xontrib load apt_tabcomplete kitty prompt_vi_mode sh
