" nunjucks syntax file
" Language: Nunjucks HTML template
" Maintainer: Hsiaoming Yang <lepture@me.com>
" Last Change: Sep 13, 2012

" only support 6.x+

if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'html'
endif

runtime! syntax/html.vim
unlet b:current_syntax

syntax case match

" frontmatter with yaml or toml
" https://www.maero.dk/markdown-frontmatter-syntax-highlighting/

syn include @yamlTop syntax/yaml.vim
syn region nunjucksFrontmatter start=/^---[json]*$/ end=/^---$/ contains=@yamlTop

" syn include @jsTop syntax/javascript.vim
" syn region jsFrontmatter start=/^---js$/ end=/^---$/ contains=@jsTop
" syn include @jsonTop syntax/json.vim
" syn region jsonFrontmatter start=/^---json$/ end=/^---$/ contains=@jsonTop
" syn region yamlFrontmatter start=/^---$/ end=/^---$/ contains=@yamlTop

" nunjucks template built-in tags and parameters
" 'comment' doesn't appear here because it gets special treatment
syn keyword nunjucksStatement contained if else elif endif is not
syn keyword nunjucksStatement contained for in recursive endfor
syn keyword nunjucksStatement contained raw endraw
syn keyword nunjucksStatement contained block endblock extends super scoped
syn keyword nunjucksStatement contained macro endmacro call endcall
syn keyword nunjucksStatement contained from import as do continue break
syn keyword nunjucksStatement contained filter endfilter set endset
syn keyword nunjucksStatement contained include ignore missing
syn keyword nunjucksStatement contained with without context endwith
syn keyword nunjucksStatement contained trans endtrans pluralize
syn keyword nunjucksStatement contained autoescape endautoescape

" nunjucks templete built-in filters
syn keyword nunjucksFilter contained abs attr batch capitalize center default
syn keyword nunjucksFilter contained dictsort escape filesizeformat first
syn keyword nunjucksFilter contained float forceescape format groupby indent
syn keyword nunjucksFilter contained int join last length list lower pprint
syn keyword nunjucksFilter contained random replace reverse round safe slice
syn keyword nunjucksFilter contained sort string striptags sum
syn keyword nunjucksFilter contained title trim truncate upper urlize
syn keyword nunjucksFilter contained wordcount wordwrap

" nunjucks template built-in tests
syn keyword nunjucksTest contained callable defined divisibleby escaped
syn keyword nunjucksTest contained even iterable lower mapping none number
syn keyword nunjucksTest contained odd sameas sequence string undefined upper

syn keyword nunjucksFunction contained range lipsum dict cycler joiner


" Keywords to highlight within comments
syn keyword nunjucksTodo contained TODO FIXME XXX

" nunjucks template constants (always surrounded by double quotes)
syn region nunjucksArgument contained start=/"/ skip=/\\"/ end=/"/
syn region nunjucksArgument contained start=/'/ skip=/\\'/ end=/'/
syn keyword nunjucksArgument contained true false

" Mark illegal characters within tag and variables blocks
syn match nunjucksTagError contained "#}\|{{\|[^%]}}\|[&#]"
syn match nunjucksVarError contained "#}\|{%\|%}\|[<>!&#%]"
syn cluster nunjucksBlocks add=nunjucksTagBlock,nunjucksVarBlock,nunjucksComBlock,nunjucksComment

" nunjucks template tag and variable blocks
syn region nunjucksTagBlock start="{%" end="%}" contains=nunjucksStatement,nunjucksFilter,nunjucksArgument,nunjucksFilter,nunjucksTest,nunjucksTagError display containedin=ALLBUT,@nunjucksBlocks
syn region nunjucksVarBlock start="{{" end="}}" contains=nunjucksFilter,nunjucksArgument,nunjucksVarError display containedin=ALLBUT,@nunjucksBlocks
syn region nunjucksComBlock start="{#" end="#}" contains=nunjucksTodo containedin=ALLBUT,@nunjucksBlocks


hi def link nunjucksTagBlock PreProc
hi def link nunjucksVarBlock PreProc
hi def link nunjucksStatement Statement
hi def link nunjucksFunction Function
hi def link nunjucksTest Type
hi def link nunjucksFilter Identifier
hi def link nunjucksArgument Constant
hi def link nunjucksTagError Error
hi def link nunjucksVarError Error
hi def link nunjucksError Error
hi def link nunjucksComment Comment
hi def link nunjucksComBlock Comment
hi def link nunjucksTodo Todo

let b:current_syntax = "nunjucks"
