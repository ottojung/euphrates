
(define-library
  (euphrates
    lalr-lexer-singlechar-additional-grammar-rules)
  (export
    lalr-lexer/singlechar:additional-grammar-rules)
  (import
    (only (euphrates lalr-lexer-singlechar-struct)
          lalr-lexer/singlechar-struct:additional-grammar-rules))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-lexer-singlechar-additional-grammar-rules.scm")))
    (else (include
            "lalr-lexer-singlechar-additional-grammar-rules.scm"))))
