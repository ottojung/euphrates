
(define-library
  (euphrates assq-unset-value)
  (export assq-unset-value)
  (import
    (only (scheme base)
          begin
          car
          define
          eq?
          lambda
          not))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/assq-unset-value.scm")))
    (else (include "assq-unset-value.scm"))))
