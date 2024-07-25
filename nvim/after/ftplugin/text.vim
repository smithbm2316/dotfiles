" Vim filetype plugin file
" Language: plain text (.txt) with `#` comments
" Author: Ben Smith
" Maintainer: Ben Smith
" Version: 1.0.0
" Last Change: 2024-07-24

if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

let b:undo_ftplugin = "setlocal cms<"

setlocal commentstring=#\ %s
