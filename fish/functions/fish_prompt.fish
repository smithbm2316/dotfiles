function fish_prompt
  # if there's an ssh connection active
  if test -n "$SSH_CONNECTION"
    set_color purple
    printf '%s' $USER
    set_color normal
    printf '@'

    set_color yellow
    echo -n (prompt_hostname)
    set_color normal
    printf ' '
  end

  set_color blue
  set -g fish_prompt_pwd_dir_length 0
  printf '%s' (prompt_pwd)
  set_color normal

  set -g __fish_git_prompt_showuntrackedfiles true
  set -g __fish_git_prompt_showdirtystate true
  set -g __fish_git_prompt_showstashstate true
  set -g __fish_git_prompt_showcolorhints true

  set -g __fish_git_prompt_char_cleanstate
  set -g __fish_git_prompt_char_dirtystate '+'
  set -g __fish_git_prompt_char_stagedstate '_'
  set -g __fish_git_prompt_char_invalidstate '~'
  set -g __fish_git_prompt_char_untrackedfiles '?'
  set -g __fish_git_prompt_char_stashstate '⚑ '
  printf '%s' (fish_git_prompt)

  # Line 2
  echo
  if test -n "$VIRTUAL_ENV"
      printf "(%s) " (set_color blue)(basename $VIRTUAL_ENV)(set_color normal)
  end
  printf '↪ '
  set_color normal
end
