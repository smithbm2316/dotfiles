" set up tsconfig path matching for `gf`
setlocal suffixesadd=.js,.jsx,.ts,.tsx,.d.ts
setlocal includeexpr=luaeval(\"require'tsconfig'.includeexpr(_A)\",v:fname)

" set up template string converter
" augroup ConvertToTemplateString
"   autocmd!
"   autocmd InsertLeave,TextChanged <buffer> lua require("convert-to-template-string").convert()
" augroup END
