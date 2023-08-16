
(define-library
  (euphrates lalr-lexer-latin-lowercases)
  (export lalr-lexer/latin/lowercases)
  (import (only (scheme base) begin define quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-lexer-latin-lowercases.scm")))
    (else (include "lalr-lexer-latin-lowercases.scm"))))
