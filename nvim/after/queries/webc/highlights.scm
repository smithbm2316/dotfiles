; inherits: html

; highlight `webc:` attributes
; adapted from: https://github.com/bennypowers/webc.nvim/blob/main/queries/html/highlights.scm
((attribute_name) @keyword
                  (#offset! @keyword 0 5 0 0)
                  (#match? @keyword "^webc:"))

; highlight `webc:root` attribute without supplying a value
; adapted from: https://github.com/bennypowers/webc.nvim/blob/main/queries/html/highlights.scm
; https://github.com/bennypowers/webc.nvim
((attribute_name) @_name
                  [
                   (attribute_value) @constant
                   (quoted_attribute_value
                     (attribute_value) @constant)
                   ]
                  (#eq? @_name "webc:root"))

; highlight `frontmatter_lang` attribute as a `keyword`
(frontmatter
  (frontmatter_lang) @keyword)
