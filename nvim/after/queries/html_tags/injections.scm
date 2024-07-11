; extends

; WebC support
; https://github.com/bennypowers/webc.nvim
((element
  (start_tag
    (tag_name) @_tag_name (#eq? @_tag_name "template")
    ((attribute
       (attribute_name) @_attr_name
       [
         (attribute_value) @_attr_val
         (quoted_attribute_value
                 ((attribute_value) @_attr_val))
       ]
       (#eq? @_attr_name "webc:type")
       (#eq? @_attr_val "md"))))
  (text) @injection.content
  (#is-filetype? "webc")
  (#set! injection.language "markdown")))

; 11ty WebC support
; https://github.com/bennypowers/webc.nvim
((element
  (start_tag
    (tag_name) @_tag_name (#eq? @_tag_name "template")
    ((attribute
       (attribute_name) @_attr1_name
       [
         (attribute_value) @_attr1_val
         (quoted_attribute_value
                 ((attribute_value) @_attr1_val))
       ]
       (#eq? @_attr1_name "webc:type")
       (#eq? @_attr1_val "11ty")
       ))
    ((attribute
       (attribute_name) @_attr2_name
       [
         (attribute_value) @_attr2_val
         (quoted_attribute_value
                 ((attribute_value) @_attr2_val))
       ]
       (#eq? @_attr2_name "11ty:type")
       (#eq? @_attr2_val "md"))))
  (text) @injection.content
  (#is-filetype? "webc")
  (#set! injection.language "markdown")))
