(call_expression
    function:
        (selector_expression field: (field_identifier) @_method)
        (#match? @_method "^Sprintf|Printf|Fprintf|Fatalf|Errorf|Logf$")
    arguments: (argument_list . (interpreted_string_literal_content) @printf)
)
