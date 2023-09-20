
(define-library
  (euphrates lalr-lexer-singlechar-run-on-string)
  (export lalr-lexer/singlechar:run-on-string)
  (import
    (only (euphrates lalr-lexer-singlechar-struct)
          lalr-lexer/singlechar-struct:lexer/string))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-lexer-singlechar-run-on-string.scm")))
    (else (include
            "lalr-lexer-singlechar-run-on-string.scm"))))
