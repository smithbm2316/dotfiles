function fish_mode_prompt
  switch $fish_bind_mode
    case default
      set_color --bold red
      echo 'n '
    case insert
      set_color --bold green
      echo 'i '
    case replace_one
      set_color --bold green
      echo 'r '
    case visual
      set_color --bold brmagenta
      echo 'v '
    case '*'
      set_color --bold red
      echo '? '
  end
  set_color normal
end
