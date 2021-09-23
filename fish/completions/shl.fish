set -l shl_cmds "rc env hist fns"
complete -f -c shl -n "not __fish_seen_subcommand_from $shl_cmds" -a $shl_cmds

# per command completion
complete -f -c shl -n "not __fish_seen_subcommand_from $shl_cmds" -a rc -d \
  "Open the login shell's main config file in \$EDITOR"
complete -f -c shl -n "not __fish_seen_subcommand_from $shl_cmds" -a env -d \
  "Open the login shell's env var definitions in \$EDITOR"
complete -f -c shl -n "not __fish_seen_subcommand_from $shl_cmds" -a hist -d \
  "Open the login shell's history file in \$EDITOR"
complete -f -c shl -n "not __fish_seen_subcommand_from $shl_cmds" -a fns -d \
  "Open the login shell's functions folder in \$EDITOR"
