#!/usr/bin/env sh
# install golang with "stefanmaric/g" version manager
curl -sSL https://git.io/g-install | sh -s

# gopls language server
go install golang.org/x/tools/gopls@latest

# install go101 website locally
# go install go101.org/go101@latest

# install godoc command
go install golang.org/x/tools/cmd/godoc@latest
