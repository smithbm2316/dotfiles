if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

let b:undo_ftplugin = "setlocal cms<"

setlocal commentstring=#\ %s
