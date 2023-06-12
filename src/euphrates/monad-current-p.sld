
(define-library
  (euphrates monad-current-p)
  (export monad-current/p)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/monad-current-p.scm")))
    (else (include "monad-current-p.scm"))))
