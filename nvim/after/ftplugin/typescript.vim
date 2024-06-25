" set up tsconfig path matching for `gf`
setlocal suffixesadd=.js,.jsx,.ts,.tsx,.d.ts
setlocal includeexpr=luaeval(\"require'tsconfig'.includeexpr(_A)\",v:fname)
