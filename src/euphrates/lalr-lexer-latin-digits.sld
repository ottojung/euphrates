
(define-library
  (euphrates lalr-lexer-latin-digits)
  (export lalr-lexer/latin/digits)
  (import (only (scheme base) begin define quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-lexer-latin-digits.scm")))
    (else (include "lalr-lexer-latin-digits.scm"))))
