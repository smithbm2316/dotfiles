; extends

; AlpineJS attributes
(attribute
  (attribute_name) @_attr
    (#lua-match? @_attr "^x%-%l")
    (#not-any-of? @_attr "x-teleport" "x-ref" "x-transition")
  (quoted_attribute_value
    (attribute_value) @injection.content)
  (#set! injection.language "javascript"))

; Blade escaped JS attributes
; <x-foo ::bar="baz" />
(element
  (_
    (tag_name) @_tag
      (#lua-match? @_tag "^x%-%l")
  (attribute
    (attribute_name) @_attr
      (#lua-match? @_attr "^::%l")
    (quoted_attribute_value
      (attribute_value) @injection.content)
    (#set! injection.language "javascript"))))

; Blade PHP attributes
; <x-foo :bar="$baz" />
(element
  (_
    (tag_name) @_tag
      (#lua-match? @_tag "^x%-%l")
    (attribute
      (attribute_name) @_attr
        (#lua-match? @_attr "^:%l")
      (quoted_attribute_value
        (attribute_value) @injection.content)
      (#set! injection.language "php_only"))))

; WebC support
; https://github.com/bennypowers/webc.nvim
((attribute_name) @_name
  [
    (attribute_value) @injection.content
    (quoted_attribute_value
      (attribute_value) @injection.content)
  ]
  (#is-filetype? "webc")
  (#not-eq? @_name "webc:root")
  (#not-eq? @_name "webc:type")
  (#not-eq? @_name "webc:type")
  (#not-eq? @_name "11ty:type")
  (#not-eq? @_name "11ty:import")
  (#match? @_name "^((webc)?:|\\@(html|raw|text))")
  (#set! injection.language "javascript"))
