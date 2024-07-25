#!/usr/bin/env sh
# further reading:
# https://rabexc.org/posts/pitfalls-of-ssh-agents
# https://www.reddit.com/r/swaywm/comments/xl8a8u/ssh_agent_on_sway_that_remembers_passwords/
# https://www.reddit.com/r/swaywm/comments/gfex9o/how_to_setup_ssh_agent/
# https://wiki.archlinux.org/title/SSH_keys#ssh-agent_as_a_wrapper_program
# https://en.opensuse.org/SDB:OpenSSH_agent
# https://upc.lbl.gov/docs/user/sshagent.shtml
#
# https://github.com/fairyglade/ly/issues/228#issuecomment-758748986

ln -s ~/dotfiles/sway/gnome-polkit/sway-with-keyring.desktop \
  /usr/share/wayland-sessions/
