# https://salferrarello.com/zsh-git-status-prompt/
# load add_zsh_hook and vcs_info
autoload -Uz add-zsh-hook vcs_info
# enable git for it
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
zstyle ':vcs_info:git:*' formats       '(%b%u%c)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'
# always load before displaying the prompt
add-zsh-hook precmd vcs_info
PROMPT='%F{red}%1~ %F{blue}${vcs_info_msg_0_}%f '$'\n''> '
