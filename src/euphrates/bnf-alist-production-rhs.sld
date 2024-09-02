
(define-library
  (euphrates bnf-alist-production-rhs)
  (export bnf-alist:production:rhs)
  (import (only (scheme base) begin cadr define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bnf-alist-production-rhs.scm")))
    (else (include "bnf-alist-production-rhs.scm"))))
