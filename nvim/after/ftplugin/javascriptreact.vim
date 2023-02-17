augroup ConvertToTemplateString
  autocmd!
  autocmd InsertLeave,TextChanged <buffer> lua require("convert-to-template-string").convert()
augroup END
