#!/usr/bin/env bash
# language servers
pnpm i -g \
  @olrtg/emmet-language-server \
  @tailwindcss/language-server \
  bash-language-server \
  fixjson \
  typescript-language-server \
  typescript \
  vscode-langservers-extracted

# ai coding agents
pnpm i -g \
  @mariozechner/pi-coding-agent \
  @sourcegraph/amp
