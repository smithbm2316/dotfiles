" copied relevant bits and pieces from the HTML and Go `$VIMRUNTIME/ftplugin`s
" that are built in to use in Templ. most of this is from the `html.vim`
" `ftplugin`, essentially just the comments stuff is from the `go.vim`
" `ftplugin`
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let s:save_cpo = &cpo
set cpo-=C

setlocal formatoptions-=t
setlocal comments=s1:/*,mb:*,ex:*/,://
setlocal matchpairs+=<:>

let b:undo_ftplugin = "setlocal formatoptions< comments< matchpairs<"

if exists("loaded_matchit") && !exists("b:match_words")
  let b:match_ignorecase = 1
  let b:match_words = '<!--:-->,' ..
	\	      '<:>,' ..
	\	      '<\@<=[ou]l\>[^>]*\%(>\|$\):<\@<=li\>:<\@<=/[ou]l>,' ..
	\	      '<\@<=dl\>[^>]*\%(>\|$\):<\@<=d[td]\>:<\@<=/dl>,' ..
	\	      '<\@<=\([^/!][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>'
  let b:html_set_match_words = 1
  let b:undo_ftplugin ..= " | unlet! b:match_ignorecase b:match_words b:html_set_match_words"
endif

let &cpo = s:save_cpo
unlet s:save_cpo
