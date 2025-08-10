" Vim syntax file
" Language: text (.txt) - extend text ft to have `#` comments
" Author: Ben Smith
" Maintainer: Ben Smith
" Version: 1.0.0
" Last Change: 2024-07-24
"
" References:
" http://i3wm.org/docs/userguide.html#configuring
" http://vimdoc.sourceforge.net/htmldoc/syntax.html

" Quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn match txtComment /#.*$/ contains=@Spell
hi def link txtComment Comment

let b:current_syntax = "text"
