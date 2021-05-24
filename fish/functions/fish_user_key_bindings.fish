function fish_user_key_bindings
  # vi-style bindings that inherit emacs-style bindings in all modes
  for mode in default insert visual
    fish_default_key_bindings -M $mode
  end
  fish_vi_key_bindings --no-erase
end
