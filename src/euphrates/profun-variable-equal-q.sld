
(define-library
  (euphrates profun-variable-equal-q)
  (export profun-variable-equal?)
  (import
    (only (euphrates profun-value)
          profun-unbound-value?)
    (only (scheme base) begin define equal? if quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-variable-equal-q.scm")))
    (else (include "profun-variable-equal-q.scm"))))
