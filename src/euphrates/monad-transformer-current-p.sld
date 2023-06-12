
(define-library
  (euphrates monad-transformer-current-p)
  (export monad-transformer-current/p)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/monad-transformer-current-p.scm")))
    (else (include "monad-transformer-current-p.scm"))))
