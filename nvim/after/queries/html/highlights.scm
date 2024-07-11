; extends

; WebC support
; https://github.com/bennypowers/webc.nvim
((attribute_name) @keyword
  (#offset! @keyword 0 5 0 0)
  (#match? @keyword "^webc:"))

((attribute_name) @_name
  [
    (attribute_value) @constant
    (quoted_attribute_value
      (attribute_value) @constant)
  ]
  (#is-filetype? "webc")
  (#eq? @_name "webc:root"))
