; https://github.com/bennypowers/template-literal-comments.nvim/blob/main/lua/template-literal-comments.lua
; extends
((comment) @_com
           (#lua-match? @_com "/%*%s*(%w+)%s*%*/")
           (template_string) @lang
             (#set-template-literal-lang-from-comment! @_com)
             (#offset! @lang 0 1 0 -1))

; https://github.com/nvim-treesitter/nvim-treesitter/blob/a6b2f4ecc8a47011868632142a9b687d7e0f9aaf/queries/ecma/injections.scm#L8
; override nvim-treesitter's injection of html`...` /  sql`...` / etc to include
; the ability for the javascript template literal function to be bound to an
; object, say like in `fastify-html` where the `html` helper is on the `reply.html`
; response helper object instead of just an imported `html` helper function
(call_expression
  function: [
    (await_expression
      (identifier) @injection.language)
    (identifier) @injection.language
    (member_expression
      (property_identifier) @injection.language)
  ]
  arguments: [
    (arguments
      (template_string) @injection.content)
    (template_string) @injection.content
  ]
  (#lua-match? @injection.language "^[a-zA-Z][a-zA-Z0-9]*$")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children)
  ; Languages excluded from auto-injection due to special rules
  ; - svg uses the html parser
  ; - css uses the styled parser
  (#not-any-of? @injection.language "svg" "css"))
