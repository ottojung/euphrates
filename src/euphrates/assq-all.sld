
(define-library
  (euphrates assq-all)
  (export assq-all)
  (import
    (only (scheme base)
          begin
          car
          cdr
          define
          eq?
          lambda
          map))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/assq-all.scm")))
    (else (include "assq-all.scm"))))
