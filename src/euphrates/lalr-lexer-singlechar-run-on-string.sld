
(define-library
  (euphrates lalr-lexer-singlechar-run-on-string)
  (export lalr-lexer/singlechar:run-on-string)
  (import
    (only (euphrates lalr-lexer-singlechar-result-struct)
          make-lalr-lexer/singlechar-result-struct))
  (import
    (only (scheme base) begin define quote string))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-lexer-singlechar-run-on-string.scm")))
    (else (include
            "lalr-lexer-singlechar-run-on-string.scm"))))
