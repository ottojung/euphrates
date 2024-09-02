
(define-library
  (euphrates bnf-alist-production-lhs)
  (export bnf-alist:production:lhs)
  (import (only (scheme base) begin car define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bnf-alist-production-lhs.scm")))
    (else (include "bnf-alist-production-lhs.scm"))))
