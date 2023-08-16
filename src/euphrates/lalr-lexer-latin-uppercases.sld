
(define-library
  (euphrates lalr-lexer-latin-uppercases)
  (export lalr-lexer/latin/uppercases)
  (import (only (scheme base) begin define quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-lexer-latin-uppercases.scm")))
    (else (include "lalr-lexer-latin-uppercases.scm"))))
