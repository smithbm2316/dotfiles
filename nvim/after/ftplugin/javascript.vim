setlocal suffixesadd+=.js,.jsx,.ts,.tsx
setlocal iskeyword+=-
setlocal omnifunc=v:lua.vim.lsp.omnifunc
set path=.,,api/**,components/**,pages/**,public/**,src/**,services/**,styles/**

" RomainL's Gist for this function: https://gist.github.com/romainl/ac4e20150ee7f8367641a3c22aab5d5b
" autocmd BufNewFile,BufRead * call <SID>DetectFrontEndFramework()

function! s:DetectFrontEndFramework()
  " check if there is a package.json file, searches up until it finds one
  let package_json = findfile('package.json', '.;')
  " check if the package.json is not empty
  if len(package_json)
    let dependencies = readfile(package_json) 
          \ ->join()
          \ ->json_decode()
          \ ->get('dependencies', {})
          \ ->keys()
    " If NextJS is in the package.json, set this path for it
    if dependencies->count('next')
      set path=.,,api/**,components/**,pages/**,public/**,ssl/**,styles/**
    " If React is in the package.json without NextJS, set this path for it
    elseif dependencies->count('react')
      set path=.,,api/**,components/**,pages/**,public/**,ssl/**,styles/**
    endif
  endif

endfunction
