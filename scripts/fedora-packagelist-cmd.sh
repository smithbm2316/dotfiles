#!/bin/bash
echo "refreshing list of explicitly installed fedora packages"
dnf repoquery --userinstalled | \
  sed -nr 's/(.*)-.:.*/\1,/p' | \
  paste -sd ' '
