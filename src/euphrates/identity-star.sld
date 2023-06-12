
(define-library
  (euphrates identity-star)
  (export identity*)
  (import
    (only (scheme base) apply begin define values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/identity-star.scm")))
    (else (include "identity-star.scm"))))
